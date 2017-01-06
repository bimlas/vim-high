function! aladdin#sources#title_description#define(settings)
  let source = aladdin#main#_Clone()

  let source.title_max = 60
  let source.description_min = 80
  let source.description_max = 150

  call aladdin#main#_Customize(source, a:settings)

  let adoc = aladdin#main#_Clone(source)
  let adoc.whitelist = ['asciidoc']
  let adoc._pattern = '^:description:\s\+\zs\(.\{,'.(source.description_min-1).'}\|.\{'.(source.description_max+1).',}\)\ze$\|^:title:\s\+\zs.\{'.(source.title_max+1).',}\ze$'
  call aladdin#main#_AddSource(adoc)

  let html = aladdin#main#_Clone(source)
  let html.whitelist = ['html']
  let html._pattern = '<meta.*name="description".*content="\zs\([^"]\{,'.(source.description_min-1).'}\|[^"]\{'.(source.description_max+1).',}\)\ze"\|<title[^>]*>\zs[^<]\{'.(source.title_max+1).',}\ze<'
  call aladdin#main#_AddSource(html)
endfunction
