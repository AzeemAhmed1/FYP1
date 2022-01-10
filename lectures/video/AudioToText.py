import speech_recognition as sr
import os
from pydub import AudioSegment
from pydub.utils import make_chunks


class AudioToText:
    def AudioToChunks(self):
        sound = AudioSegment.from_file("audio.wav")
        chunk_length_ms = 180 * 1000  # pydub calculates in millisec
        chunks = make_chunks(sound, chunk_length_ms)
        return chunks
    def ChunksToText(self, chunks):

        r = sr.Recognizer()
        whole_text = ""
        for i, audio_chunk in enumerate(chunks, start=1):
            chunk_filename = os.path.join(f"chunk{i}.wav")
            audio_chunk.export(chunk_filename, format="wav")
            # recognize the chunk
            with sr.AudioFile(chunk_filename) as source:
                r.adjust_for_ambient_noise(source)
                audio_listened = r.record(source)
            # try converting it to text
            try:
                text = r.recognize_google(audio_listened)
            except sr.UnknownValueError as e:
                print("Error:", str(e))
            else:
                text = f"{text.capitalize()}. "
                # print(chunk_filename, ":", text)
                whole_text += text

                os.remove(chunk_filename)
        return whole_text


