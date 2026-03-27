/**
 * 标签项数据接口
 */
export interface GlassTabItem {
  /** 标签文字 */
  title: string;
  /** 默认状态图标资源 */
  icon: Resource;
  /** 选中状态图标资源，未设置时使用 icon */
  selectedIcon?: Resource;
  /** 角标数量，大于 0 时显示红点角标 */
  badge?: number;
}

/**
 * 毛玻璃底部导航栏组件
 *
 * 支持图标 + 文字 + 选中指示点，具有切换动效。
 * 通常配合页面级 Stack 定位到屏幕底部使用。
 *
 * 使用示例：
 * ```
 * // 定义标签数据
 * private tabs: GlassTabItem[] = [
 *   { title: '首页', icon: $r('sys.symbol.house') },
 *   { title: '发现', icon: $r('sys.symbol.magnifyingglass') },
 *   { title: '我的', icon: $r('sys.symbol.person') },
 * ]
 *
 * // 渲染导航栏
 * GlassTabBar({
 *   tabs: this.tabs,
 *   currentIndex: this.tabIndex,
 *   onTabChange: (index) => { this.tabIndex = index; }
 * })
 * ```
 */
@ComponentV2
export struct GlassTabBar {
  /** 标签数据数组 */
  @Param tabs: GlassTabItem[] = [];
  /** 当前选中标签索引，从 0 开始 */
  @Param currentIndex: number = 0;
  /** 选中态颜色，默认绿色 */
  @Param activeColor: ResourceColor = '#5DD784';
  /** 未选中态颜色，默认 40% 白 */
  @Param inactiveColor: ResourceColor = 'rgba(255, 255, 255, 0.4)';
  /** 导航栏高度（vp），默认 64 */
  @Param barHeight: number = 64;
  /** 距底部安全区距离（vp），默认 24 */
  @Param bottomOffset: number = 24;
  /** 左右边距（vp），默认 24 */
  @Param horizontalMargin: number = 24;
  /** 导航栏圆角（vp），默认 32（胶囊形） */
  @Param barRadius: number = 32;
  /** 标签切换回调，参数为目标索引 */
  @Event onTabChange: (index: number) => void = () => {};

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: GlassTabItem, index: number) => {
          Column({ space: 4 }) {
            // 图标：选中时使用 selectedIcon，尺寸放大
            SymbolGlyph(index === this.currentIndex && tab.selectedIcon ? tab.selectedIcon : tab.icon)
              .fontSize(index === this.currentIndex ? 24 : 20)
              .fontColor([index === this.currentIndex ? this.activeColor : this.inactiveColor])
              .animation({ duration: 150, curve: Curve.EaseOut })

            // 标签文字
            Text(tab.title)
              .fontSize(index === this.currentIndex ? 11 : 10)
              .fontWeight(index === this.currentIndex ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(index === this.currentIndex ? this.activeColor : this.inactiveColor)
              .animation({ duration: 150, curve: Curve.EaseOut })

            // 选中指示点
            Column()
              .width(4)
              .height(4)
              .borderRadius(2)
              .backgroundColor(index === this.currentIndex ? this.activeColor : Color.Transparent)
              .animation({ duration: 150, curve: Curve.EaseOut })
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onTabChange(index);
          })
        })
      }
      .width('100%')
      .height(this.barHeight)
      .borderRadius(this.barRadius)
      .backgroundBlurStyle(BlurStyle.Thin)
      .backgroundColor('rgba(20, 20, 40, 0.6)')
      .border({ width: 0.5, color: 'rgba(255, 255, 255, 0.12)' })
      .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.2)', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .padding({ left: this.horizontalMargin, right: this.horizontalMargin, bottom: this.bottomOffset })
  }
}
