if has("gui_macvim")
  " colorscheme twilight

  set guifont=MesloLGMDZ:h12

  " Start without the toolbar
  set guioptions=egmrt

  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " CTRLP
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>
  set wildignore+=*/.git/*,**/vendor/**,**/bin/*,**/tmp/*,*/.*

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " TextMate style indentation
  nmap <D-]> >>
  nmap <D-[> <<
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt

  " Close all open buffers on entering a window if the only
  " buffer that's left is the NERDTree buffer
  function s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
      if bufwinnr(t:NERDTreeBufName) != -1
        if winnr("$") == 1
          q
        endif
      endif
    endif
  endfunction
endif
