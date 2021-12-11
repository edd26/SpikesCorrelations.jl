using SpikesCorrelations
using Test

@testset "SpikesCorrelations.jl" begin
    # Write your tests here.
    include("test_CorrelationIndex.jl")
    include("test_SpikeTrain.jl")
    include("test_TilingCoefficient.jl")
    include("test_VPDistance.jl")
end
