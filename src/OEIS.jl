module OEIS

using HTTP, IterTools

import Base: show
export oeis

# Parse OEIS internal format
# see https://oeis.org/eishelp1.html for a description
# we are interested in:
#   %I id number (A followed by 6-digit number)
#   %S, %T, %U absolute values of terms (%T, %U optional)
#   %V, %W, %X signed values (only if sequence contains negative numbers)
#   %N name

mutable struct IntegerSequence{T<:Integer}
    id::Symbol
    name::String
    values::Vector{T}
end

function show(io::IO,seq::IntegerSequence)
    println(io, string(typeof(seq)), ": ", string(seq.id))
    println(io, "  ", seq.name)
    if length(seq.values) <= 20 
        print(io, "  ", join(seq.values,','))
    else
        print(io, "  ", join(seq.values[1:20],','),",...")
    end
end

# there has to be a better way than this...
function bestint(s::AbstractString)
    inttypes = [Int8, Int16, Int32, Int64, Int128, UInt128]
    for T in inttypes
        n = tryparse(T, s)
        n != nothing && return n
    end
    return parse(BigInt, s)
end


function parse_oeis_page(s::String)
    if occursin("Too many results. Please narrow search.", s)
        error("Too many results. Please narrow search.")
    end
    seqs = IntegerSequence[]
    lines = filter(l -> length(l)>=10 && l[1]=='%', split(s, '\n') )
    for r in groupby(l -> l[4:10], lines)
        push!(seqs, parse_oeis_record(r))
    end
    seqs
end

function parse_oeis_record(r)
    local id, name, vec
    for line in r
        C = line[2]
        if C == 'I'
            id = line[4:10]
        elseif C == 'N'
            name = line[12:end]
        elseif C in ('S','V')
            vec = Integer[bestint(s) for s in split(line[12:end], ',', keepempty=false)]
        elseif C in ('T','U','W','X')
            append!(vec, Integer[bestint(s) for s in split(line[12:end], ',' , keepempty=false)])
        end
    end
    if all(i -> isa(i,Int), vec)
        vec = Int[i for i in vec]
    end
    IntegerSequence(Symbol(id), String(name), vec)
end



function oeis(query::String)
    r = HTTP.get("http://oeis.org/search"; query=Dict("fmt" => "text", "q" => query))
     parse_oeis_page(String(r.body))
end

function oeis(id::Symbol)
    r = HTTP.get("http://oeis.org/search"; query=Dict("fmt" => "text", "q" => string("id:",id)))
    #parse_oeis_page(r.data)[1] TODO remove
    parse_oeis_page(String(r.body))[1]
end

function oeis(seq::Array)
    r = HTTP.get("http://oeis.org/search"; query=Dict("fmt" => "text", "q" => join(seq,',')))
    parse_oeis_page(String(r.body))
end


end # module
