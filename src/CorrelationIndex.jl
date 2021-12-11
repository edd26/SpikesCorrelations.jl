
function correlation_index(
    spike_vactor1::Array,
    spike_vactor2::Array,
    delta_t::Float64,
    Time::Float64,
)
    total_spikes1 = length(spike_vactor1)
    total_spikes2 = length(spike_vactor2)

    interval_spikes = 0
    spike_index2 = 1

    for spike_index1 = 1:total_spikes1
        # for spike_index2=1:total_spikes2
        # TODO Shouldn't the spike_index2 be reset here?
        while (spike_index2 < total_spikes2)
            spike_interval =
                spike_vactor1[spike_index1] - spike_vactor2[spike_index2]
            if spike_itnerval > delta_t
                spike_index2 = spike_index2 + 1

            elseif fabs(spike_interval) <= delta_t
                interval_spikes += 1

                u = spike_index2 + 1

                while (
                    abs(spike_vactor1[spike_index1] - spike_vactor2[u]) <=
                    delta_t
                )
                    interval_spikes += 1
                    u += 1
                end
                break
            else
                break
            end
        end
    end

    signal_duration = Time[1] - Time[0]
    return index =
        (interval_spikes * signal_duration) /
        (total_spikes1 * total_spikes2 * 2 * delta_t)
end
