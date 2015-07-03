" projconf.vim
" Brief: Set tags file for per project
" Version: 0.5
" Date: Jul. 04, 2015
" Author: Yuxuan 'fishy' Wang <fishywang@gmail.com>
" Maintainer: Alberto Fanjul <albertofanjul@gmail.com>
"

function! SetProjConf()
	if exists("g:ProjConf")
		for item in g:ProjConf
			try
				let [filepattern; tagfiles] = item
				if match(filepattern, "\/$") == -1
					let filepattern .= "/"
				endif
				let filepattern .= "*"
			catch /.*List.*/ " item is not a list
				if match(item, "\/$") == -1
					let item .= "/"
				endif
				let filepattern = item . "*"
				let tagfiles = [item . "tags"]
			endtry
			for tagfile in tagfiles
				if match(tagfile, "^:") != -1
					let cmd = substitute(tagfile, "^:set ", ":setlocal ", "")
					execute 'autocmd BufEnter ' . filepattern . ' ' . cmd 
				else
					execute 'autocmd BufEnter ' . filepattern . ' :setlocal tags+=' . tagfile 
				endif
			endfor
			unlet item
		endfor
	endif
endfunc

call SetProjConf()

