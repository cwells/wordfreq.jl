module WordFreq
export analyze, top, summarize, PhraseFrequency, FrequencyTable

using Printf

Phrase, Frequency = String, Int64
PhraseFrequency = Pair{Phrase, Frequency}
FrequencyTable = Dict{Phrase, Frequency}
Summary = Base.Iterators.Enumerate{Array{PhraseFrequency, 1}}

"""
    analyze(text, stride)

Analyzes `text` and returns a dictionary describing
the frequency of phrases of `stride` word length.
"""
function analyze(text::String, stride::Int64)::FrequencyTable
  table = FrequencyTable()
  words = split(lowercase(text), r"[^a-z0-9'$%]"; keepempty=false)
  count = length(words)

  if count < stride return table end

  for i in 1 : (count - count % stride) - stride + 1
    slice = @views words[i : i + stride - 1]
    phrase = join(slice, " ")
    table[phrase] = get(table, phrase, 0) + 1
  end

  table
end

"""
    top(highest, frequencies)

Sorts frequency data and returns a ranked summary of the
phrases with the highest frequencies, up to `highest` results,
in descending order.
"""
function top(highest::Int64, frequencies::FrequencyTable)::Summary
  enumerate(sort!(
    collect(frequencies),
    by  = (phrase, frequency)::PhraseFrequency -> frequency,
    rev = true
  )[1 : min(highest, end)])
end

"""
    summarize(filename, stride, highest)

Analyzes the provided file and summarizes the results.
"""
function summarize(filename::String, stride::Int64 = 3, highest::Int64 = 10)::String
  summary = [ @sprintf("%4s %5s   %s", "rank", "freq", "phrase") ]

  open(filename, "r") do file
    text = read(file, String)
    frequencies = analyze(text, stride)
    for (rank, (phrase, frequency)) in top(highest, frequencies)
      append!(summary, [ @sprintf("%4i %5i   %s", rank, frequency, phrase) ])
    end
  end

  join(summary, "\n")
end

end
