import { GlassColors } from '../constants/GlassColors';
import { GlassShadows } from '../constants/GlassStyles';

/**
 * 毛玻璃面板组件
 *
 * 高规格毛玻璃容器，顶部边框高亮、内置顶部光晕覆层，适合作为页面主内容区域或重要信息卡片。
 * 与 GlassCard 的区别：面板边框采用四边差异化宽度与颜色，视觉层次更强。
 *
 * 使用示例：
 * ```
 * GlassPanel({
 *   content: () => {
 *     Text('面板内容')
 *   }
 * })
 *
 * // 自定义阴影等级与光晕强度
 * GlassPanel({
 *   shadowLevel: 4,
 *   glowOpacity: 0.3,
 *   content: () => { ... }
 * })
 * ```
 */
@ComponentV2
export struct GlassPanel {
  /** 内边距，默认 16vp，支持 Padding 对象 */
  @Param panelPadding: Length | Padding = 16;
  /** 圆角大小（vp），默认 20 */
  @Param panelRadius: number = 20;
  /** 基础边框宽度（vp），顶部为 2 倍、底部为 0.5 倍，默认 1 */
  @Param panelBorderWidth: number = 1;
  /** 顶部光晕不透明度，默认 0.2 */
  @Param glowOpacity: number = 0.2;
  /** 阴影等级 1~4，默认 3 */
  @Param shadowLevel: number = 3;
  /** 背景模糊风格，默认 BlurStyle.Thin */
  @Param blurStyle: BlurStyle = BlurStyle.Thin;
  /** 内容插槽 */
  @BuilderParam content: () => void = this.defaultContent;

  @Builder
  private defaultContent(): void {}

  /** 顶部白色渐变光晕覆层（不可点击，仅视觉效果） */
  @Builder
  private glowOverlay(): void {
    Column()
      .width('100%')
      .height('40%')
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(255, 255, 255, ' + this.glowOpacity.toString() + ')', 0],
          ['rgba(255, 255, 255, 0)', 1]
        ] as [ResourceColor, number][]
      })
      .borderRadius({
        topLeft: this.panelRadius,
        topRight: this.panelRadius,
        bottomLeft: 0,
        bottomRight: 0
      })
      .hitTestBehavior(HitTestMode.Transparent)
  }

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .padding(this.panelPadding)
    .borderRadius(this.panelRadius)
    .backgroundColor(Color.Transparent)
    .backgroundBlurStyle(this.blurStyle)
    .border({
      width: {
        top: this.panelBorderWidth * 2,
        left: this.panelBorderWidth,
        right: this.panelBorderWidth,
        bottom: this.panelBorderWidth * 0.5
      },
      color: {
        top: GlassColors.PANEL_BORDER_TOP,
        left: GlassColors.PANEL_BORDER_MID,
        right: GlassColors.PANEL_BORDER_MID,
        bottom: GlassColors.PANEL_BORDER_BOTTOM
      }
    })
    .shadow(GlassShadows.getShadowByLevel(this.shadowLevel))
    .overlay(this.glowOverlay, { align: Alignment.Top })
  }
}
