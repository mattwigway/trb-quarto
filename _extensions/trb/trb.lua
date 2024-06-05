words = 0
tables = 0

countwords = {
    Str = function(el)
        -- we don't count a word if it's entirely punctuation:
        if el.text:match("%P") then
            words = words + 1
        end
    end,

    Code = function(el)
        _,n = el.text:gsub("%S+","")
        words = words + n
    end,

    CodeBlock = function(el)
        _,n = el.text:gsub("%S+","")
        words = words + n
    end
}

trbfilter = {
    Table = function (el)
        -- if it's a table, just count it as a table
        tables = tables + 1
    end,

    Block = function (el)
        -- everything else gets counted
        quarto.log.output(getmetatable(el))
        -- otherwise, count words
        pandoc.walk_block(el, countwords)
    end,

    Meta = function(meta)
        quarto.log.output("Words " .. words)
        meta.nwords = words
        if tables == 1 then
            meta.ntables = "1 table"
        else
            meta.ntables = tables .. " tables"
        end
        meta.nwords_with_tables = words + tables * 250
        return meta
    end
}

return {trbfilter}