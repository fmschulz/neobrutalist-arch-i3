# Neobrutalist colorscheme for ranger
# Black background with bold white borders and text

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
            fg = white
            attr = bold  # Everything is bold by default
            
            if context.selected:
                # Selected items: stark white background, black text
                bg = white
                fg = black
                attr = bold
            
            if context.empty or context.error:
                fg = red
                bg = black
                attr = bold
                
            if context.border:
                # Bold white borders - this is key for visible lines
                fg = white
                bg = black
                attr = bold
                
            if context.media:
                if context.image:
                    fg = yellow
                    bg = black
                    attr = bold
                else:
                    fg = cyan
                    bg = black
                    attr = bold
                    
            if context.container:
                fg = red
                bg = black
                attr = bold
                
            if context.directory:
                fg = white
                bg = black
                attr = bold
                
            elif context.executable and not \
                    any((context.media, context.container,
                         context.fifo, context.socket)):
                fg = green
                bg = black
                attr = bold
                
            if context.socket:
                fg = magenta
                bg = black
                attr = bold
                
            if context.fifo or context.device:
                fg = yellow
                bg = black
                attr = bold
                    
            if context.link:
                fg = cyan if context.good else magenta
                bg = black
                attr = bold
                
            if context.tag_marker and not context.selected:
                attr = bold
                bg = black
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
                    
            if not context.selected and (context.cut or context.copied):
                fg = black
                bg = yellow  # Make cut/copied items visible
                attr = bold
                
            if context.main_column:
                bg = black
                if context.selected:
                    attr = bold
                if context.marked:
                    fg = yellow
                    bg = black
                    attr = bold
                    
            if context.badinfo:
                fg = red
                bg = black
                attr = bold

        elif context.in_titlebar:
            # Title bar: white text on black background
            bg = black
            fg = white
            attr = bold
            
            if context.hostname:
                fg = red if context.bad else white
                bg = black
                attr = bold
            elif context.directory:
                fg = white
                bg = black
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
                bg = black
                attr = bold

        elif context.in_statusbar:
            # Status bar: white text on black background
            bg = black
            fg = white
            attr = bold
            
            if context.permissions:
                if context.good:
                    fg = white
                    bg = black
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
                    bg = black
                    attr = bold
                else:
                    fg = white
                    bg = black
                    attr = bold
            if context.loaded:
                fg = black
                bg = white
                attr = bold
            if context.vcsinfo:
                fg = cyan
                bg = black
                attr = bold
            if context.vcscommit:
                fg = yellow
                bg = black
                attr = bold

        if context.text:
            bg = black
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            bg = black
            fg = white
            attr = bold
            
            if context.title:
                fg = white
                bg = black
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
            bg = black
            attr = bold
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
            bg = black
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