# TODO Design test cases

Δ1 = 20 # Millisecond
Δ2 = 200 # Millisecond
Δ3 = 500 # Millisecond

inter1 = 8.# Millisecond
inter2 = 10.# Millisecond

time_resolution = 1000

simplest_train = vcat([ [inter1 * k for k in 1:5] .+ Δ1,
                        [inter2 * k for k in 1:3] .+ Δ2,
                        ]...
                    ) ./time_resolution
simplest_train2 = simplest_train .+ 0.003#Second

simplest_train_doubled = vcat([
                                ([inter1/2 * k for k in 1:5] .+ Δ1 .+12),
                                ([inter2/2 * k for k in 1:3] .+ Δ2 .+10),
                                ]...
                            ) ./time_resolution
simplest_train_doubled2  = simplest_train_doubled  .+ 0.003#Second


spike_vector = vcat([ [inter1 * k for k in 1:5] .+ Δ1,
                        [inter1 * k for k in 1:3] .+ Δ2,
                        [inter2 * k for k in 1:5] .+ Δ3,
                        ]...
                    ) ./time_resolution
spike_vector2 = spike_vector .+ 0.003
Δt = 4/time_resolution
start_time = 0
stop_time = 500/ time_resolution
stop_time = 1000/ time_resolution
tailing_coefficient(spike_vector, spike_vector, Δt, start_time, stop_time,)

# Necessary properties, described in the paper introducing the measure
# N1 Symmetry: The measure C should be symmetric: for spike trains
# A and B, C(A, B)==C(B, A)
@test tailing_coefficient(spike_vector, spike_vector2, Δt, start_time, stop_time,) ==
            tailing_coefficient(spike_vector2, spike_vector, Δt, start_time, stop_time,)


# N2 Robust to variations in the firing rate: For instance, given two spike
# trains with a particular correlational structure, if the rates of both trains
# are doubled but the structure is preserved, the correlation measure should
# remain the same.

@test tailing_coefficient(
            simplest_train,
            simplest_train2,
            Δt,
            start_time,
            stop_time,
        ) == tailing_coefficient(
            simplest_train_doubled,
            simplest_train_doubled2,
            Δt,
            start_time,
            stop_time,
        ) broken=true

# N3 Robust to amount of data: In practice, this often means robust to recording
# duration.
@test abs(tailing_coefficient(
                simplest_train,
                simplest_train2,
                Δt,
                start_time,
                stop_time,
            ) - tailing_coefficient(
                simplest_train,
                simplest_train2,
                Δt,
                start_time,
                stop_time + 0.05,
            ),
        ) < 0.01

# N4 Bounded: The measure should be bounded taking a value of1 when the spike
# trains are identical, with a value of zero corresponding to no correlation and
# 1 corresponding to anti-correlation.
@test tailing_coefficient(
                simplest_train,
                simplest_train,
                Δt,
                start_time,
                stop_time,
            )  == 1 broken=true

@test tailing_coefficient(
                simplest_train,
                simplest_train.+0.5,
                Δt,
                start_time,
                stop_time,
            )  == 0 broken=true
# N5 Robust to variations in t: Small variations to t should not introduce
# artefacts into the measure.
@test abs(tailing_coefficient(
                simplest_train,
                simplest_train2,
                Δt,
                start_time,
                stop_time,
            ) - tailing_coefficient(
                simplest_train,
                simplest_train2,
                Δt+0.0005,
                start_time,
                stop_time,
            ),
        ) < 0.00108

# N6 Anticorrelation: The measure should discriminate between no correlation and
# anticorrelation.
# TODO this one I have no idea how to approach
