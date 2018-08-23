push!(LOAD_PATH, "../..")

using Test, WordFreq

@testset "All tests" begin
  text = "Repeat this string, don't repeat this one. Don't repeat this string."

  @testset "analyze" begin
    @test FrequencyTable(
      "this one"     => 1,
      "one don't"    => 1,
      "don't repeat" => 2,
      "repeat this"  => 3,
      "string don't" => 1,
      "this string"  => 1
    ) == analyze(text, 2)

    @test FrequencyTable(
    ) == analyze("too few", 3)

    @test FrequencyTable(
      "length equals stride" => 1
    ) == analyze("length equals stride", 3)
  end

  @testset "top" begin
    @test Tuple{Int64, PhraseFrequency}[
      (1, "repeat this"  => 3),
      (2, "don't repeat" => 2),
      (3, "this one"     => 1)
    ] == collect(top(3, analyze(text, 2)))
  end
end