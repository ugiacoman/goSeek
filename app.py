# author: oskar.blom@gmail.com
#
# Make sure your gevent version is >= 1.0
import gevent
from gevent.wsgi import WSGIServer
from gevent.queue import Queue
import json
import string
import random

from flask import Flask, Response

import time


# SSE "protocol" is described here: http://mzl.la/UPFyxY
class ServerSentEvent(object):

    def __init__(self, data, event=None, id=None):
        self.data = data
        self.event = event
        self.id = id
        self.d_map = {
            "event": self.event,
            "data": self.data,
            "id": self.id,
        }

    def encode(self):
        if not self.data:
            return ""
        return "event: %s\ndata: %s\n\n" % (self.d_map.get("event", ""), self.d_map.get("data"))


def id_generator(size=4, chars=string.ascii_uppercase):
    return ''.join(random.choice(chars) for _ in range(size))


app = Flask(__name__)
subscriptions = []
seekers = []
player_count = 0

# Client code consumes like this.
@app.route("/")
def index():
    debug_template = """
     <html>
       <head>
       </head>
       <body>
         <h1>Server sent events</h1>
         <div id="event"></div>
         <script type="text/javascript">

         var eventOutputContainer = document.getElementById("event");
         var evtSrc = new EventSource("/polo");

         evtSrc.onmessage = function(e) {
             console.log("e: " + e);
             console.log("event: " + e.data.event);
             console.log("data: " + e.data);
             console.log("id: " + e.id);
             eventOutputContainer.innerHTML = e.data;
         };

         </script>
       </body>
     </html>
    """
    return(debug_template)

@app.route("/debug")
def debug():
    return "Currently %d subscriptions" % len(subscriptions)

# generates a roomcode string and returns json
@app.route("/roomcode")
def roomcode():
    global player_count
    player_count = 0
    roomcode = id_generator()
    return json.dumps({"roomcode": roomcode})

# seeker wants hiders to yell polo
@app.route("/marco")
def marco():
    def notify():
        msg = ("marco", "MARCO")
        map(lambda sub: sub.put(msg), subscriptions)
    gevent.spawn(notify)
    return "OK"

# seeker initiates countdown
@app.route("/countdown")
def test():
    def notify():
        for x in xrange(5,-1,-1):
            msg = (str(x), "COUNTDOWN")
            map(lambda sub: sub.put(msg), subscriptions)
            map(lambda sub: sub.put(msg), seekers)
            gevent.sleep(1)
    gevent.spawn(notify)
    return "OK"

@app.route("/add_player")
def add_player():
    global player_count
    player_count += 1
    def notify():
        msg = (str(player_count), "ADD_PLAYER")
        map(lambda sub: sub.put(msg), subscriptions)
        map(lambda sub: sub.put(msg), seekers)
    gevent.spawn(notify)
    return "OK"

# close connection to server
@app.route("/close")
def close():
    def notify():
        msg = ("close", "CLOSE")
        map(lambda sub: sub.put(msg), subscriptions)
    gevent.spawn(notify)
    return "OK"

# event source for hiders
@app.route("/seeker")
def seeker():
    def gen():
        q = Queue()
        seekers.append(q)
        try:
            while True:
                (data, etype) = q.get()
                ev = ServerSentEvent(str(data), str(etype))
                yield ev.encode()
        except GeneratorExit: # Or maybe use flask signals
            seekers.remove(q)

    return Response(gen(), mimetype="text/event-stream")

# event source for hiders
@app.route("/polo")
def polo():
    def gen():
        q = Queue()
        subscriptions.append(q)
        try:
            while True:
                (data, etype) = q.get()
                ev = ServerSentEvent(str(data), str(etype))
                yield ev.encode()
        except GeneratorExit: # Or maybe use flask signals
            subscriptions.remove(q)

    return Response(gen(), mimetype="text/event-stream")

if __name__ == "__main__":
    app.debug = True
    server = WSGIServer(("", 5000), app)
    server.serve_forever()
    # Then visit http://localhost:5000 to subscribe 
    # and send messages by visiting http://localhost:5000/publish
