# Harmonization script

source activate magenta

BUNDLE_PATH=/Users/Will/Desktop/climate_sonification/polyphony_rnn.mag

polyphony_rnn_generate
--bundle_file=${BUNDLE_PATH}
--ouput_dir=/Users/Will/Desktop/tmp/
--num_outputs=2
--num_steps=2560
--primer_midi=/Users/Will/Desktop/climate_sonification/data_sonfication.mid
--condition_on_primer=false
--inject_primer_during_generation=false
