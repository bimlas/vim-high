function! aladdin#sources#title_description#define(settings)
  let source = aladdin#main#_Clone()
  call aladdin#main#_Customize(source, a:settings)

  let adoc = aladdin#main#_Clone(source)
  let adoc.whitelist = ['asciidoc']
  let adoc._pattern = '^:description:\s\+\zs\(.\{,80}\|.\{150,}\)\ze$\|^:title:\s\+\zs.\{60,}\ze$'
  call aladdin#main#_AddSource(adoc)

  let html = aladdin#main#_Clone(source)
  let html.whitelist = ['html']
  let html._pattern = '\(<meta.*name="description".*content="\zs\([^"]\{,80}\|[^"]\{150,}\)\ze"\)\|<title[^>]*>\zs[^<]\{60,}\ze<'
  call aladdin#main#_AddSource(html)
endfunction
