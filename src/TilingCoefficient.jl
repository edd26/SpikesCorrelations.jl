
# double run_P(int N1,int N2,double dt,double *spike_times_1,double *spike_times_2){
function run_P(spike_times_1::Vector{<:Real},
                spike_times_2::Vector{<:Real},
                dt::Real,
            )::Float64
    Nab = 0
    N1 = length(spike_times_1)
    N2 = length(spike_times_2)

    spike_index2 = 1
    for spike_index1 = 1:N1
        while (spike_index2 < N2)
            # check every spike in train 1 to see if there's a spike in train 2 within dt  (don't count spike pairs)
            # don't need to search all spike_index2 each iteration
            if abs(spike_times_1[spike_index1] - spike_times_2[spike_index2]) <=
               dt
                Nab = Nab + 1
                break
            elseif spike_times_2[spike_index2] > spike_times_1[spike_index1]
                break
            else
                spike_index2 = spike_index2 + 1
            end # if
        end # while
    end # for

    return Nab
end



# double run_T(int N1v,double dtv,double startv, double endv, double *spike_times_1)
"""
dt is the window size used for searching for spike cooccurance

TODO: what is missing now is the how the vectors should be defined, because this would remove ambiguity about the time resolutions
"""
function run_T(spike_times_1::Vector{<:Real},
                dt::Real,
                start_time::Real,
                stop_time::Real,
            )::Float64
    N1 = length(spike_times_1)
    vec_index = 1

    # maximum
    time_A = 2 * N1 * dt

    #  if just one spike in train
    if N1 == 1
        first_spike_time = spike_times_1[0]
        if first_spike_time - start_time < dt
            time_A = time_A - start_time + first_spike_time - dt
        elseif first_spike_time + dt > stop_time
            time_A = time_A - first_spike_time - dt + stop_time
        end
    else # if more than one spike in train
        while vec_index < N1
            dif_index = vec_index + 1
            diff = spike_times_1[dif_index] - spike_times_1[vec_index]

            if diff < 2 * dt # subtract overlap
                time_A = time_A - 2 * dt + diff
            end
            vec_index += 1
        end

        # check if spikes are within dt of the start_time and/or end, if so just need to subract
        # overlap of first and/or last spike as all within-train overlaps have been accounted for
        if spike_times_1[1] - start_time < dt
            time_A = time_A - start_time + spike_times_1[1] - dt
        end

        if stop_time - spike_times_1[N1-1] < dt
            time_A = time_A - spike_times_1[N1] - dt + stop_time
        end
    end

    return time_A
end



# void run_sttc(int *N1v,int *N2v,double *dtv,double *Time,double *index,double *spike_times_1,double *spike_times_2){
function tailing_coefficient(spike_times_1::Vector{<:Real},
                                spike_times_2::Vector{<:Real},
                                dt::Real,
                                start_time::Real,
                                stop_time::Real,
                            )

    N1 = length(spike_times_1)
    N2 = length(spike_times_2)

    if (N1 == 0 || N2 == 0)
        index = NaN
    else
        T = stop_time - start_time
        # TA=run_T(N1,dt,Time[0],Time[1], spike_times_1) / T
        # TB=run_T(N2,dt,Time[0],Time[1], spike_times_2) / T
        # PA=run_P(N1,N2,dt, spike_times_1, spike_times_2) / N1
        # PB=run_P(N2,N1,dt, spike_times_2, spike_times_1) / N2

        TA = run_T(spike_times_1, dt, start_time, stop_time) / T
        TB = run_T(spike_times_2, dt, start_time, stop_time) / T
        PA = run_P(spike_times_1, spike_times_2, dt) / N1
        PB = run_P(spike_times_2, spike_times_1, dt) / N2

        index =
            0.5 * (PA - TB) / (1 - TB * PA) + 0.5 * (PB - TA) / (1 - TA * PB)
    end

    return index
end
