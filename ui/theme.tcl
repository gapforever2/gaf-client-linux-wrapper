package require Tk

set bg_color   "#1e1e2e"
set bg_header  "#181825"
set fg_main    "#cdd6f4"
set fg_title   "#a6adc8"
set btn_bg     "#313244"
set btn_hover  "#45475a"
set border_c   "#313244"

wm overrideredirect . 1
wm attributes . -topmost 1

proc init_base_window {title} {
    global bg_color bg_header fg_title border_c
    
    frame .f -relief solid -borderwidth 1 -bg $border_c
    pack .f -fill both -expand 1

    frame .f.head -bg $bg_header -bd 0
    label .f.head.title -text $title -font {Helvetica 10 bold} -bg $bg_header -fg $fg_title -padx 15 -pady 8
    pack .f.head.title -side left

    set ::mouse_x 0; set ::mouse_y 0
    foreach w {.f.head .f.head.title} {
        bind $w <ButtonPress-1> {set ::mouse_x %x; set ::mouse_y %y}
        bind $w <B1-Motion> {
            set nx [expr {%X - $::mouse_x}]
            set ny [expr {%Y - $::mouse_y}]
            wm geometry . "+$nx+$ny"
        }
    }

    frame .f.line1 -height 1 -bg $border_c
    
    pack .f.head -side top -fill x
    pack .f.line1 -side top -fill x

    frame .f.body -bg $bg_color -padx 30 -pady 20
    pack .f.body -side top -fill both -expand 1
    
    return .f.body
}

proc style_button {btn_path} {
    global btn_bg fg_main btn_hover
    $btn_path configure -bg $btn_bg -fg $fg_main \
        -activebackground $btn_hover -activeforeground $fg_main \
        -relief flat -borderwidth 0 -highlightthickness 0

    bind $btn_path <Enter> [list $btn_path configure -bg $btn_hover]
    bind $btn_path <Leave> [list $btn_path configure -bg $btn_bg]
}

proc center_window {} {
    update idletasks
    set w [winfo reqwidth .]
    set h [winfo reqheight .]
    set x [expr {([winfo screenwidth .] - $w) / 2}]
    set y [expr {([winfo screenheight .] - $h) / 2}]
    wm geometry . "${w}x${h}+${x}+${y}"
}

bind . <Escape> {exit 0}
