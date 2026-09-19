source [file join [file dirname [info script]] "theme.tcl"]

set title "Gaf Client: Legacy"
set text [string map {"\\n" "\n"} [join $argv " "]]

set body [init_base_window $title]

label $body.lbl -text $text -justify center -font {Helvetica 10} -bg $bg_color -fg $fg_main
button $body.btn -text "ОК" -width 12 -font {Helvetica 9 bold} -pady 5 -command {exit 0}

style_button $body.btn

pack $body.lbl -side top -fill both -expand 1 -pady {0 15}
pack $body.btn -side top

center_window
