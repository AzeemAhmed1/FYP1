import VideoToAudio
import AudioToText
from flask import Flask, jsonify, request

app = Flask(__name__)


@app.route('/api', methods=['GET'])
def generatedText():
    d = {}
    the_video = str(request.args['query'])
    if the_video is not None:
        VidToAudio = VideoToAudio.VideoToAudio()
        VidToAudio.VideoToAudio(the_video)
        audio = AudioToText.AudioToText()
        chunk = audio.AudioToChunks()
        #print(len(chunk))
        text = audio.ChunksToText(chunk)
        #print(text)
        result = text

    else:
        result = "No File Selected"

    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)