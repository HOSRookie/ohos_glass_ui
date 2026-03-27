import { GlassColors } from '../constants/GlassColors';
import { GlassShadows, GlassAnimations } from '../constants/GlassStyles';

/**
 * 按钮类型枚举
 */
export enum GlassButtonType {
  /** 主按钮（绿色渐变背景） */
  PRIMARY = 'primary',
  /** 次要按钮（毛玻璃背景 + 边框） */
  SECONDARY = 'secondary',
  /** 危险按钮（红色边框，用于删除、退出等操作） */
  DANGER = 'danger',
  /** 幽灵按钮（透明背景 + 白色边框） */
  GHOST = 'ghost'
}

/**
 * 毛玻璃按钮组件
 *
 * 支持四种风格：主按钮、次要按钮、危险按钮、幽灵按钮。
 * 具备加载态、禁用态以及按下缩放反馈动效。
 *
 * 使用示例：
 * ```
 * // 主按钮
 * GlassButton({
 *   text: '保存',
 *   type: GlassButtonType.PRIMARY,
 *   onTap: () => this.save()
 * })
 *
 * // 危险按钮
 * GlassButton({
 *   text: '退出登录',
 *   type: GlassButtonType.DANGER,
 *   onTap: () => this.logout()
 * })
 *
 * // 加载态
 * GlassButton({
 *   text: '提交',
 *   loading: true
 * })
 * ```
 */
@ComponentV2
export struct GlassButton {
  /** 按钮文字 */
  @Param text: string = '';
  /** 按钮类型，默认主按钮 */
  @Param type: GlassButtonType = GlassButtonType.PRIMARY;
  /** 是否禁用，禁用时不可点击且样式变灰 */
  @Param disabled: boolean = false;
  /** 是否加载中，加载时显示进度条并锁定交互 */
  @Param loading: boolean = false;
  /** 按钮高度（vp），默认 48 */
  @Param buttonHeight: number = 48;
  /** 圆角大小（vp），默认 16 */
  @Param buttonRadius: number = 16;
  /** 是否撑满父容器宽度，默认 true */
  @Param fullWidth: boolean = true;
  /** 点击回调 */
  @Event onTap: () => void = () => {};

  @Local private isPressed: boolean = false;

  private getTextColor(): ResourceColor {
    if (this.disabled) {
      return GlassColors.TEXT_DISABLED;
    }
    switch (this.type) {
      case GlassButtonType.PRIMARY:
        return GlassColors.TEXT_PRIMARY;
      case GlassButtonType.SECONDARY:
        return GlassColors.TEXT_PRIMARY;
      case GlassButtonType.DANGER:
        return GlassColors.DANGER;
      case GlassButtonType.GHOST:
        return GlassColors.TEXT_PRIMARY;
      default:
        return GlassColors.TEXT_PRIMARY;
    }
  }

  private getBorderColor(): ResourceColor {
    if (this.disabled) {
      return GlassColors.BORDER_LIGHTER;
    }
    switch (this.type) {
      case GlassButtonType.PRIMARY:
        return GlassColors.BG_TRANSPARENT;
      case GlassButtonType.SECONDARY:
        return GlassColors.BORDER_DEFAULT;
      case GlassButtonType.DANGER:
        return GlassColors.DANGER;
      case GlassButtonType.GHOST:
        return GlassColors.BORDER_GHOST;
      default:
        return GlassColors.BG_TRANSPARENT;
    }
  }

  private getShadow(): ShadowOptions {
    if (this.disabled || this.type !== GlassButtonType.PRIMARY) {
      return GlassShadows.NONE;
    }
    return this.isPressed ? GlassShadows.PRIMARY_BUTTON_PRESSED : GlassShadows.PRIMARY_BUTTON;
  }

  @Builder
  private buildPrimaryButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .linearGradient({
      angle: 90,
      colors: this.disabled
        ? [[GlassColors.BG_DISABLED, 0], [GlassColors.BG_DISABLED, 1]]
        : [[GlassColors.PRIMARY, 0], [GlassColors.PRIMARY_DARK, 0.5], [GlassColors.PRIMARY_DARKER, 1]]
    })
    .shadow(this.getShadow())
    .scale({
      x: this.isPressed && !this.disabled ? 0.98 : 1.0,
      y: this.isPressed && !this.disabled ? 0.98 : 1.0
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: GlassAnimations.DURATION_FAST, curve: GlassAnimations.CURVE_DEFAULT })
  }

  @Builder
  private buildSecondaryButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(Color.Transparent)
    .backgroundBlurStyle(BlurStyle.Thin)
    .border({ width: 1, color: this.getBorderColor() })
    .scale({
      x: this.isPressed && !this.disabled ? 0.98 : 1.0,
      y: this.isPressed && !this.disabled ? 0.98 : 1.0
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }

  @Builder
  private buildDangerButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(GlassColors.DANGER)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: this.getBorderColor() })
    .scale({
      x: this.isPressed && !this.disabled ? 0.98 : 1.0,
      y: this.isPressed && !this.disabled ? 0.98 : 1.0
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: 100, curve: Curve.EaseOut })
  }

  @Builder
  private buildGhostButton(): void {
    Row() {
      if (this.loading) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color(Color.White)
          .margin({ right: 8 })
      }
      Text(this.loading ? '处理中...' : this.text)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.getTextColor())
    }
    .width(this.fullWidth ? '100%' : 'auto')
    .height(this.buttonHeight)
    .padding(this.fullWidth ? 0 : { left: 24, right: 24 })
    .justifyContent(FlexAlign.Center)
    .borderRadius(this.buttonRadius)
    .backgroundColor(this.isPressed ? GlassColors.BG_HOVER : GlassColors.BG_TRANSPARENT)
    .border({ width: 0.5, color: this.getBorderColor() })
    .scale({
      x: this.isPressed && !this.disabled ? 0.98 : 1.0,
      y: this.isPressed && !this.disabled ? 0.98 : 1.0
    })
    .opacity(this.isPressed && !this.disabled ? 0.9 : 1.0)
    .animation({ duration: GlassAnimations.DURATION_FAST, curve: GlassAnimations.CURVE_DEFAULT })
  }

  build() {
    Column() {
      if (this.type === GlassButtonType.PRIMARY) {
        this.buildPrimaryButton()
      } else if (this.type === GlassButtonType.SECONDARY) {
        this.buildSecondaryButton()
      } else if (this.type === GlassButtonType.DANGER) {
        this.buildDangerButton()
      } else {
        this.buildGhostButton()
      }
    }
    .enabled(!this.disabled && !this.loading)
    .onTouch((event: TouchEvent) => {
      if (this.disabled || this.loading) return;
      if (event.type === TouchType.Down) {
        this.isPressed = true;
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false;
      }
    })
    .onClick(() => {
      if (!this.disabled && !this.loading && this.onTap) {
        this.onTap();
      }
    })
  }
}
