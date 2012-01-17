if has("gui_macvim")
  set guifont=MesloLGMDZ:h12

  " Start without the toolbar
  set guioptions=egmrt

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " CtrlP
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " TextMate style indentation
  nmap <D-]> >>
  nmap <D-[> <<
  vmap <D-]> >gv
  vmap <D-[> <gv
endif
