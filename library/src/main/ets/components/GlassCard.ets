import { GlassColors } from '../constants/GlassColors';
import { GlassShadows, GlassAnimations } from '../constants/GlassStyles';

/**
 * 毛玻璃卡片组件
 *
 * 通用毛玻璃容器，支持标题、可点击态、顶部光晕效果。
 * 子内容通过 `content` BuilderParam 插槽注入。
 *
 * 使用示例：
 * ```
 * // 基础卡片
 * GlassCard({
 *   title: '基本信息',
 *   content: () => {
 *     Text('内容区域')
 *   }
 * })
 *
 * // 可点击卡片
 * GlassCard({
 *   clickable: true,
 *   onTap: () => router.pushUrl({ url: 'pages/Detail' }),
 *   content: () => { ... }
 * })
 *
 * // 带顶部光晕
 * GlassCard({
 *   showGlow: true,
 *   glowColor: '#5DD784',
 *   content: () => { ... }
 * })
 * ```
 */
@ComponentV2
export struct GlassCard {
  /** 卡片标题，为空时不渲染标题行 */
  @Param title: string = '';
  /** 标题字号（vp），默认 16 */
  @Param titleSize: number = 16;
  /** 是否可点击，开启后有按下缩放动效 */
  @Param clickable: boolean = false;
  /** 内边距，默认 16vp，支持 Padding 对象 */
  @Param cardPadding: Length | Padding = 16;
  /** 圆角大小（vp），默认 16 */
  @Param cardRadius: number = 16;
  /** 背景模糊风格，默认 BlurStyle.Thin */
  @Param blurStyle: BlurStyle = BlurStyle.Thin;
  /** 阴影等级 1~4，默认 1 */
  @Param shadowLevel: number = 1;
  /** 是否显示顶部光晕覆层 */
  @Param showGlow: boolean = false;
  /** 光晕颜色，默认白色 */
  @Param glowColor: ResourceColor = GlassColors.GLOW_DEFAULT;
  /** 光晕不透明度，默认 0.25 */
  @Param glowOpacity: number = 0.25;
  /** 点击回调（需配合 clickable: true） */
  @Event onTap: () => void = () => {};
  /** 内容插槽 */
  @BuilderParam content: () => void = this.defaultContent;

  @Local private isPressed: boolean = false;

  @Builder
  private defaultContent(): void {}

  private getShadow(): ShadowOptions {
    return GlassShadows.getShadowByLevel(this.shadowLevel);
  }

  /** 顶部渐变光晕覆层（不可点击，仅视觉效果） */
  @Builder
  private glowOverlay(): void {
    Column()
      .width('100%')
      .height('40%')
      .linearGradient({
        angle: 180,
        colors: [
          [this.glowColor, 0],
          ['rgba(255, 255, 255, 0)', 1]
        ] as [ResourceColor, number][]
      })
      .opacity(this.glowOpacity)
      .borderRadius({
        topLeft: this.cardRadius,
        topRight: this.cardRadius,
        bottomLeft: 0,
        bottomRight: 0
      })
      .hitTestBehavior(HitTestMode.Transparent)
  }

  build() {
    Column({ space: 16 }) {
      if (this.title) {
        Text(this.title)
          .fontSize(this.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(GlassColors.TEXT_PRIMARY)
          .width('100%')
      }

      this.content()
    }
    .width('100%')
    .padding(this.cardPadding)
    .backgroundColor(Color.Transparent)
    .backgroundBlurStyle(this.blurStyle)
    .border({
      width: this.showGlow ? { top: 2, left: 1, right: 1, bottom: 0.5 } : 1,
      color: this.showGlow
        ? {
          top: GlassColors.BORDER_GLOW_TOP,
          left: GlassColors.BORDER_DEFAULT,
          right: GlassColors.BORDER_DEFAULT,
          bottom: GlassColors.BORDER_LIGHTER
        }
        : 'rgba(255, 255, 255, 0.15)'
    })
    .borderRadius(this.cardRadius)
    .shadow(this.getShadow())
    .scale({
      x: this.clickable && this.isPressed ? 0.98 : 1.0,
      y: this.clickable && this.isPressed ? 0.98 : 1.0
    })
    .opacity(this.clickable && this.isPressed ? 0.9 : 1.0)
    .animation({ duration: 150, curve: Curve.EaseOut })
    .onTouch((event: TouchEvent) => {
      if (!this.clickable) return;
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (this.clickable && this.onTap) {
        this.onTap();
      }
    })
    .overlay(this.showGlow ? this.glowOverlay : undefined, { align: Alignment.Top })
  }
}

/**
 * 毛玻璃列表项组件
 *
 * 适用于设置页、菜单等场景，支持图标、标题、副标题、右侧文字和箭头。
 *
 * 使用示例：
 * ```
 * GlassListItem({
 *   icon: $r('sys.symbol.person'),
 *   title: '个人信息',
 *   subtitle: '查看和编辑',
 *   onTap: () => router.pushUrl({ url: 'pages/Profile' })
 * })
 *
 * // 危险操作（红色文字）
 * GlassListItem({
 *   icon: $r('sys.symbol.arrow_right_square'),
 *   title: '退出登录',
 *   danger: true,
 *   showArrow: false,
 *   onTap: () => this.logout()
 * })
 * ```
 */
@ComponentV2
export struct GlassListItem {
  /** 列表项标题 */
  @Param title: string = '';
  /** 副标题，为空时不渲染 */
  @Param subtitle: string = '';
  /** 左侧图标资源，为 null 时不渲染 */
  @Param icon: Resource | null = null;
  /** 右侧说明文字，为空时不渲染 */
  @Param rightText: string = '';
  /** 是否显示右侧箭头，默认 true */
  @Param showArrow: boolean = true;
  /** 是否为危险操作，开启后文字变红 */
  @Param danger: boolean = false;
  /** 点击回调 */
  @Event onTap: () => void = () => {};

  @Local private isPressed: boolean = false;

  build() {
    Row() {
      if (this.icon) {
        SymbolGlyph(this.icon)
          .fontSize(22)
          .fontColor([this.danger ? '#FF4D4F' : Color.White])
          .margin({ right: 12 })
      }

      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(16)
          .fontColor(this.danger ? '#FF4D4F' : Color.White)
          .fontWeight(FontWeight.Medium)

        if (this.subtitle) {
          Text(this.subtitle)
            .fontSize(12)
            .fontColor('rgba(255, 255, 255, 0.5)')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.rightText) {
        Text(this.rightText)
          .fontSize(14)
          .fontColor('rgba(255, 255, 255, 0.5)')
          .margin({ right: 8 })
      }

      if (this.showArrow) {
        SymbolGlyph($r('sys.symbol.chevron_right'))
          .fontSize(18)
          .fontColor(['rgba(255, 255, 255, 0.4)'])
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.isPressed ? 'rgba(255, 255, 255, 0.08)' : Color.Transparent)
    .backgroundBlurStyle(BlurStyle.Thin)
    .borderRadius(12)
    .scale({ x: this.isPressed ? 0.99 : 1.0, y: this.isPressed ? 0.99 : 1.0 })
    .animation({ duration: 100, curve: Curve.EaseOut })
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (this.onTap) {
        this.onTap();
      }
    })
  }
}
