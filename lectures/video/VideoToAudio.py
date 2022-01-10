import moviepy.editor

class VideoToAudio:

    def VideoToAudio(self, video):
        vide = moviepy.editor.VideoFileClip(video)
        audio = vide.audio
        audio.write_audiofile("audio.wav")



