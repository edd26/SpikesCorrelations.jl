# # ======================
# Example usage
# using CSV
# using Plots
#
# TODO data for test could be potentially proided with artifacts
# file_name = "sts_for_VP_test.csv"
# csv_matrix = CSV.read(file_name)[:,2:end]
# almost_not_csv_matrix = Matrix(csv_matrix)
#
# file_name2 = "spikes.csv"
# spikes = load_csv_file_to_array(file_name2)
#
# file_name3 = "th_chunks.csv"
# th_chunks = load_csv_file_to_array(file_name3)
#
# sts = generate_spike_matrix(spikes; th_chunks=th_chunks)
# VPd = [get_selfdist(s; n_chan=32, cost=60., dt=0.01) for s in sts]
#
#
# get_selfdist(st_inp; n_chan=32, cost=60., dt=0.01)
# spkd(s1, s2, cost)
#


#=
An example from other library that computes VP distance

(source:
https://elephant.readthedocs.io/en/latest/reference/_spike_train_processing.html#module-elephant.spike_train_dissimilarity
)
=#

cost = 1
st_a = [10, 20, 30] ./ 10
st_b = [12, 24, 30] ./ 10

result = spkd(st_a, st_b, cost)

@test Int(ceil(result*1000)) == 600
