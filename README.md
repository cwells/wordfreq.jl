# wordfreq.jl

Coding challenge in Julia. Count how many times phrases occur in arbitrary text.

```julia
julia> push!(LOAD_PATH, "..")
4-element Array{String,1}:
 "@"
 "@v#.#"
 "@stdlib"
 ".."

julia> using WordFreq

julia> main("data/oos.txt", 3)

 rank   freq   phrase (stride 3)
    1    320   of the same
    2    130   the same species
    3    125   conditions of life
    4    117   in the same
    5    110   of natural selection
    6    104   from each other
    7    102   species of the
    8     89   on the other
    9     81   the other hand
   10     78   the case of

julia>
```
