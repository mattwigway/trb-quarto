nwords = 0
ntables = 0

-- based on https://github.com/pandoc/lua-filters/blob/master/wordcount/wordcount.lua
countwords = {
    Str = function(el)
        -- we don't count a word if it's entirely punctuation:
        if el.text:match("%P") then
            nwords = nwords + 1
        end
    end,

    Code = function(el)
        _,n = el.text:gsub("%S+","")
        nwords = nwords + n
    end,

    CodeBlock = function(el)
        _,n = el.text:gsub("%S+","")
        nwords = nwords + n
    end
}

trbfilter = {
    Table = function (el)
        -- if it's a table, just count it as a table
        ntables = ntables + 1
    end,

    Block = function (el)
        -- everything else gets counted
        pandoc.walk_block(el, countwords)
    end,

    Meta = function(meta)
        if meta.nwords ~= nil then
            nwords = tonumber(pandoc.utils.stringify(meta.nwords))
        end

        if meta.ntables ~= nil then
            ntables = tonumber(pandoc.utils.stringify(meta.ntables))
        end

        quarto.log.output("Words " .. nwords)
        quarto.log.output("Tables " .. ntables)

        meta.nwords = nwords
        if tables == 1 then
            meta.ntables = "1 table"
        else
            meta.ntables = tostring(ntables) .. " tables"
        end
        meta.nwords_with_tables = nwords + ntables * 250

        -- Create the author header
        -- see https://github.com/quarto-journals/jss/blob/a5b928a765e0d87cc40aedcbf4302b8ce2ad5c9c/_extensions/jss/jss.lua#L49-L65
        if (meta.authorheader == nil) then
            local byAuthor = meta['by-author']

            if #byAuthor == 1 then
                meta.authorheader = pandoc.utils.stringify(byAuthor[1].name.family)
            elseif #byAuthor == 2 then
                meta.authorheader = pandoc.utils.stringify(byAuthor[1].name.family) .. " and " .. pandoc.utils.stringify(byAuthor[2].name.family)
            elseif #byAuthor == 3 then
                meta.authorheader = pandoc.utils.stringify(byAuthor[1].name.family) .. ", " .. pandoc.utils.stringify(byAuthor[2].name.family) .. ", and " .. pandoc.utils.stringify(byAuthor[3].name.family)
            else
                meta.authorheader = pandoc.utils.stringify(byAuthor[1].name.family) .. " et al."
            end
        end

        return meta
    end
}

return {trbfilter}