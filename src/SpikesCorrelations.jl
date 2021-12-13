module SpikesCorrelations

"CorrelationIndex.jl" |> include
# "SpikesCorrelations.jl" |> include
"TilingCoefficient.jl" |> include
"VPDistance.jl" |> include

# Write your package code here.
export correlation_index, tailing_coefficient, spkd


end

# TODO:
# - set up documentation
# - add tests
# - refactor vp distance, so that it is similar to other functions
# - check out how to write a function that takes other functions as argument, just like in distances library
