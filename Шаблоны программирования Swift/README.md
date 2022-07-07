# Frames vs Bounds

- **frame** = местоположение и размер вида с использованием **системы координат родительского вида** (важно для размещения вида в родительском вью)
  

- **bounds** = расположение и размер представления с использованием **собственной системы координат** (важно для размещения содержимого представления или подвидов внутри себя)

Frame(Рамка) в iOS похожа на рамку картины на стене. Они относятся к super view. И они особо не меняются.

Bounds is the coordinate systems within the frame itself. There is a distinction. Because while the frame rarely changes, the bounds inside the view does. This is how `UIScrollViews` work as well as animations. They change their bounds but leave their frames.

Bounds(Границы) — это системы координат внутри самого кадра. Фрейм меняется редко, bounds внутри view меняются чаще - так работают `UIScrollViews`, а также анимация. Они меняют свои bounds, но оставляют свои frames.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/FramesVsBounds/images/frame1.png"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/FramesVsBounds/images/frame2.png"/>

