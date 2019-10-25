# Data Sonification Project - LITR 0110D
import csv
from datetime import datetime
from miditime.miditime import MIDITime
from scipy import stats
import math

# instantiate the MITITime class with tempo 120 and 5sec/year
mymidi = MIDITime(120, 'data_sonfication.mid', 1, 5, 1)

# load in climate data as dictionary
climate_data = []
with open('GLB.Ts+dSST.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    # skip headers (first 2 rows)
    next(readCSV)
    next(readCSV)
    for row in readCSV:
        climate_data.append(
        {'days_since_epoch': mymidi.days_since_epoch(datetime.strptime(row[0], '%Y')),
         'magnitude_change': row[17]
         })

my_data_timed = [
    {'beat': mymidi.beat(d['days_since_epoch']),
     'magnitude_change': float(d['magnitude_change'])} for d in climate_data]
start_time = my_data_timed[0]['beat']
data_list = [d['magnitude_change'] for d in my_data_timed]

def mag_to_pitch_tuned(magnitude):
    """
    Consumes some magnitude value and normalizes it over the range of note
    values provided from a key.
    :param magnitude: some int or float value representing magnitude of data
    :return: a MIDI pitch represented by the normalized value
    """
    # Where does this data point sit in the domain of your data?
    #(I.E. the min magnitude is 3, the max in 5.6). In this case the optional
    #'True' means the scale is reversed, so the highest value will return the
    #lowest percentage.
    scale_pct = mymidi.linear_scale_pct(min(data_list), max(data_list), magnitude)

    # Another option: Linear scale, reverse order
    # scale_pct = mymidi.linear_scale_pct(3, 5.7, magnitude_change, True)

    # Another option: Logarithmic scale, reverse order
    # scale_pct = mymidi.log_scale_pct(3, 5.7, magnitude_change, True)

    # Pick a range of notes. This allows you to play in a key.
    c_major = ['C', 'D', 'E', 'F', 'G', 'A', 'B']

    #Find the note that matches your data point
    note = mymidi.scale_to_note(scale_pct, c_major)

    #Translate that note to a MIDI pitch
    midi_pitch = mymidi.note_to_midi_pitch(note)

    return midi_pitch

note_list = []

z_scores = stats.zscore(data_list)
exp_score = [math.ceil(math.exp(x)*4)/4 for x in z_scores]

i = 0
for d in my_data_timed:
    note_list.append([
        d['beat'] - start_time,
        mag_to_pitch_tuned(d['magnitude_change']),
        100,  # velocity
        exp_score[i]  # duration, in beats
    ])
    i += 1

# Add a track with those notes
mymidi.add_track(note_list)

# Output the .mid file
mymidi.save_midi()


#sum = sum(exp_score)
#softmax_score = [x / sum for x in exp_score]
print(exp_score)
