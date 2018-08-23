push!(LOAD_PATH, "../..")

using Documenter, WordFreq

makedocs(
  source  = "src",
  build   = "build",
  clean   = true,
  doctest = true,
  modules = Module[WordFreq]
)