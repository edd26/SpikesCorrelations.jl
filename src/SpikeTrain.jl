
"""
Current elements:
    :times: (quantity array 1D, numpy array 1D, or list) The times of each spike.
    :units: (quantity units) Required if :attr:`times` is a list or :class:`~numpy.ndarray`, not if it is a :class:`~quantities.Quantity`.
    :t_stop: (quantity scalar, numpy scalar, or float) Time at which :class:`SpikeTrain` ended. This will be converted to the same units as :attr:`times`. This argument is required because it specifies the period of time over which spikes could have occurred.  Note that :attr:`t_start` is highly recommended for the same reason.
    :t_start: (quantity scalar, numpy scalar, or float) Time at which :class:`SpikeTrain` began. This will be converted to the same units as :attr:`times`.  Default: 0.0 seconds.
    :name: (str) A label for the dataset.
    :description: (str) Text description.
    :file_origin: (str) Filesystem path or URL of the original data file.
    :waveforms: (quantity array 3D (spike, channel, time)) The waveforms of each spike.
    :sampling_rate: (quantity scalar) Number of samples per unit time for the waveforms.
    :left_sweep: (quantity array 1D) Time from the beginning of the waveform to the trigger time of the spike.
    :sort: (bool) If True, the spike train will be sorted by time.

"""
struct SpikeTrain
    times::Array
    t_stop::Number
    t_sart::Number
		name::String
		description::String
    waveforms::Array
    sampling_rate::Number
    left_sweep::Number
    right_sweep::Number
    sort::Bool
end
