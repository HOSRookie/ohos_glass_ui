import { GlassColors } from '../constants/GlassColors';
import { GlassRadius, GlassShadows, GlassAnimations } from '../constants/GlassStyles';

/** Toast 图标类型 */
export type GlassToastIcon = 'success' | 'error' | 'warning' | 'none';

/**
 * 毛玻璃轻提示组件
 *
 * 在页面顶部区域弹出短暂提示信息，支持成功、错误、警告三种图标风格。
 * 显示后自动在 `duration` 毫秒后调用 `onClose` 关闭，调用方负责将 `visible` 置为 false。
 *
 * 使用示例：
 * ```
 * // 基础文字提示
 * GlassToast({
 *   visible: this.showToast,
 *   message: '保存成功',
 *   onClose: () => { this.showToast = false; }
 * })
 *
 * // 带图标提示
 * GlassToast({
 *   visible: this.showToast,
 *   message: '操作失败，请重试',
 *   icon: 'error',
 *   duration: 3000,
 *   onClose: () => { this.showToast = false; }
 * })
 * ```
 */
@ComponentV2
export struct GlassToast {
  /** 是否显示 Toast */
  @Param visible: boolean = false;
  /** 提示文字内容 */
  @Param message: string = '';
  /** 图标类型：success / error / warning / none，默认 none */
  @Param icon: GlassToastIcon = 'none';
  /** 自动关闭延迟（ms），默认 2000ms，设为 0 则不自动关闭 */
  @Param duration: number = 2000;
  /** 自动关闭回调，调用方需在此将 visible 置为 false */
  @Event onClose: () => void = () => {};

  private timerId: number = -1;

  @Monitor('visible')
  onVisibleChange(): void {
    if (this.timerId >= 0) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
    if (this.visible && this.duration > 0) {
      this.timerId = setTimeout(() => {
        this.onClose();
        this.timerId = -1;
      }, this.duration);
    }
  }

  aboutToDisappear(): void {
    if (this.timerId >= 0) {
      clearTimeout(this.timerId);
      this.timerId = -1;
    }
  }

  private getIconResource(): Resource | null {
    switch (this.icon) {
      case 'success':
        return $r('sys.symbol.checkmark_circle');
      case 'error':
        return $r('sys.symbol.xmark_circle');
      case 'warning':
        return $r('sys.symbol.exclamationmark_triangle');
      default:
        return null;
    }
  }

  private getIconColor(): ResourceColor {
    switch (this.icon) {
      case 'success':
        return GlassColors.SUCCESS;
      case 'error':
        return GlassColors.DANGER;
      case 'warning':
        return GlassColors.WARNING;
      default:
        return GlassColors.TEXT_PRIMARY;
    }
  }

  build() {
    if (this.visible) {
      Column() {
        Row({ space: 8 }) {
          if (this.icon !== 'none' && this.getIconResource()) {
            SymbolGlyph(this.getIconResource())
              .fontSize(20)
              .fontColor([this.getIconColor()])
          }

          Text(this.message)
            .fontSize(14)
            .fontColor(GlassColors.TEXT_PRIMARY)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .borderRadius(GlassRadius.TOAST)
        .backgroundColor(GlassColors.BG_TRANSPARENT)
        .backgroundBlurStyle(BlurStyle.Thin)
        .border({ width: 1, color: GlassColors.BORDER_DEFAULT })
        .shadow(GlassShadows.LEVEL_3)
      }
      .width('100%')
      .position({ x: 0, y: 80 })
      .alignItems(HorizontalAlign.Center)
      .hitTestBehavior(HitTestMode.Transparent)
      .transition(TransitionEffect.opacity(0.01).animation({ duration: GlassAnimations.DURATION_SLOW }))
    }
  }
}
