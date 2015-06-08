module OEIS

using Requests

export oeis

function oeis(seq::Array)
    r = get("http://oeis.org/search"; query={"fmt" => "text", "q" => string(seq)}).data
    r = split(r, "\n")
    filter!(x->(length(x) >= 2 &&(x[1:2] == "%S" || x[1:2] == "%N")),r)
    map!(x->x[2:end], r)

    for line in r
        c= split(line)
        lineend = c[1] == "N" ? "\n" : ""
        println("\x1b[36m", c[1]," \x1b[32m",c[2]," \x1b[0m",join(c[3:end], " "), lineend)
    end
end

function oeis(id::String)
    r = get("http://oeis.org/search"; query={"fmt" => "text", "q" => string("id:",id)}).data
    r = split(r, "\n")
    filter!(x->(length(x) >= 2 &&(x[1:2] == "%S" || x[1:2] == "%N")),r)
    map!(x->x[2:end], r)

    for line in r
        c= split(line)
        lineend = c[1] == "N" ? "\n" : ""
        println("\x1b[36m", c[1]," \x1b[32m",c[2]," \x1b[0m",join(c[3:end], " "), lineend)
    end
end
end # module
