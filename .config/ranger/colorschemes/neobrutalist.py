# Neobrutalist colorscheme for ranger
# Ultra-bold black and white with maximum contrast

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class Neobrutalist(ColorScheme):
    progress_bar_color = white

    def use(self, context):
        fg, bg, attr = white, black, bold  # Default: bold white on black

        if context.reset:
            return white, black, bold

        elif context.in_browser:
            # Force black background for all browser contexts
            bg = black
            attr = bold  # Everything is bold by default
            
            if context.selected:
                # Selected items: stark white background, black text
                bg = white
                fg = black
                attr = bold
            else:
                fg = white  # Default white text
                
            if context.empty or context.error:
                fg = red
                bg = black
                attr = bold
                
            if context.border:
                fg = white
                attr = bold
                
            if context.media:
                if context.image:
                    fg = yellow
                    attr = bold
                else:
                    fg = cyan
                    attr = bold
                    
            if context.container:
                fg = red
                attr = bold
                
            if context.directory:
                fg = white
                attr = bold  # Directories extra bold
                
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = green
                attr = bold
                
            if context.socket:
                fg = magenta
                attr = bold
                
            if context.fifo or context.device:
                fg = yellow
                attr = bold
                    
            if context.link:
                fg = cyan if context.good else magenta
                attr = bold
                
            if context.tag_marker and not context.selected:
                attr = bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
                    
            if not context.selected and (context.cut or context.copied):
                fg = black
                bg = yellow  # Make cut/copied items more visible
                attr = bold
                
            if context.main_column:
                if context.selected:
                    attr = bold
                if context.marked:
                    fg = yellow
                    attr = bold
                    
            if context.badinfo:
                fg = red
                bg = black
                attr = bold

        elif context.in_titlebar:
            bg = black
            fg = white
            attr = bold
            
            if context.hostname:
                fg = red if context.bad else white
                attr = bold
            elif context.directory:
                fg = white
                attr = bold
            elif context.tab:
                if context.good:
                    fg = black
                    bg = white
                    attr = bold
                else:
                    fg = white
                    bg = black
                    attr = bold
            elif context.link:
                fg = cyan
                attr = bold

        elif context.in_statusbar:
            bg = black
            fg = white
            attr = bold
            
            if context.permissions:
                if context.good:
                    fg = white
                    attr = bold
                elif context.bad:
                    fg = red
                    bg = black
                    attr = bold
            if context.marked:
                fg = yellow
                bg = black
                attr = bold | reverse
            if context.message:
                if context.bad:
                    fg = red
                    attr = bold
                else:
                    fg = white
                    attr = bold
            if context.loaded:
                bg = white
                fg = black
                attr = bold
            if context.vcsinfo:
                fg = cyan
                attr = bold
            if context.vcscommit:
                fg = yellow
                attr = bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            bg = black
            fg = white
            attr = bold
            
            if context.title:
                fg = white
                attr = bold

            if context.selected:
                fg = black
                bg = white
                attr = bold

            if context.loaded:
                if context.selected:
                    fg = black
                    bg = white
                else:
                    fg = white
                    bg = black
                attr = bold

        # Version control with bold styling
        if context.vcsfile and not context.selected:
            attr = bold  # Make VCS files bold too
            if context.vcsconflict:
                fg = magenta
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = green
            elif context.vcssync:
                fg = green
            elif context.vcsignored:
                fg = white

        elif context.vcsremote and not context.selected:
            attr = bold
            if context.vcssync:
                fg = green
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = cyan
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr