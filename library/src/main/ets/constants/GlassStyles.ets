import { GlassColors } from './GlassColors';

/**
 * 毛玻璃 UI 阴影预设
 *
 * 提供 4 个通用阴影等级以及按钮专用阴影，统一阴影风格。
 *
 * 使用示例：
 * ```
 * .shadow(GlassShadows.LEVEL_2)
 * .shadow(GlassShadows.PRIMARY_BUTTON)
 * .shadow(GlassShadows.getShadowByLevel(3))
 * ```
 */
export class GlassShadows {
  /** 一级阴影（最轻，偏移 2px） */
  static readonly LEVEL_1: ShadowOptions = {
    radius: 8,
    color: GlassColors.SHADOW_DEFAULT,
    offsetX: 0,
    offsetY: 2
  };

  /** 二级阴影（偏移 4px） */
  static readonly LEVEL_2: ShadowOptions = {
    radius: 12,
    color: GlassColors.SHADOW_MEDIUM,
    offsetX: 0,
    offsetY: 4
  };

  /** 三级阴影（偏移 6px） */
  static readonly LEVEL_3: ShadowOptions = {
    radius: 16,
    color: GlassColors.SHADOW_STRONG,
    offsetX: 0,
    offsetY: 6
  };

  /** 四级阴影（最重，偏移 8px） */
  static readonly LEVEL_4: ShadowOptions = {
    radius: 24,
    color: GlassColors.SHADOW_STRONGER,
    offsetX: 0,
    offsetY: 8
  };

  /** 主色按钮默认阴影（绿色光晕） */
  static readonly PRIMARY_BUTTON: ShadowOptions = {
    radius: 12,
    color: GlassColors.SHADOW_PRIMARY,
    offsetX: 0,
    offsetY: 2
  };

  /** 主色按钮按下阴影（绿色光晕加深） */
  static readonly PRIMARY_BUTTON_PRESSED: ShadowOptions = {
    radius: 16,
    color: GlassColors.SHADOW_PRIMARY_PRESSED,
    offsetX: 0,
    offsetY: 4
  };

  /** 无阴影 */
  static readonly NONE: ShadowOptions = {
    radius: 0,
    color: Color.Transparent,
    offsetX: 0,
    offsetY: 0
  };

  /**
   * 根据等级获取阴影配置
   * @param level 阴影等级，取值 1~4，超出范围返回 LEVEL_1
   */
  static getShadowByLevel(level: number): ShadowOptions {
    switch (level) {
      case 1:
        return GlassShadows.LEVEL_1;
      case 2:
        return GlassShadows.LEVEL_2;
      case 3:
        return GlassShadows.LEVEL_3;
      case 4:
        return GlassShadows.LEVEL_4;
      default:
        return GlassShadows.LEVEL_1;
    }
  }
}

/**
 * 毛玻璃 UI 圆角预设
 *
 * 使用示例：
 * ```
 * .borderRadius(GlassRadius.MEDIUM)
 * ```
 */
export class GlassRadius {
  /** 小圆角，适用于输入框、列表项等 */
  static readonly SMALL = 12;
  /** 中圆角，适用于按钮、卡片等 */
  static readonly MEDIUM = 16;
  /** 大圆角，适用于面板、弹窗等 */
  static readonly LARGE = 20;
  /** 超大圆角 */
  static readonly XLARGE = 24;
  /** 完全圆形，适用于标签栏、胶囊按钮 */
  static readonly ROUND = 32;
  /** Toast 专用圆角 */
  static readonly TOAST = 22;
}

/**
 * 毛玻璃 UI 间距预设（单位：vp）
 *
 * 使用示例：
 * ```
 * .padding(GlassSpacing.DEFAULT)
 * Column({ space: GlassSpacing.SM })
 * ```
 */
export class GlassSpacing {
  /** 超小间距 4vp */
  static readonly XS = 4;
  /** 小间距 8vp */
  static readonly SM = 8;
  /** 中间距 12vp */
  static readonly MD = 12;
  /** 默认间距 16vp */
  static readonly DEFAULT = 16;
  /** 大间距 20vp */
  static readonly LG = 20;
  /** 超大间距 24vp */
  static readonly XL = 24;
  /** 最大间距 32vp */
  static readonly XXL = 32;
}

/**
 * 毛玻璃 UI 动画预设
 *
 * 使用示例：
 * ```
 * .animation({ duration: GlassAnimations.DURATION_FAST, curve: GlassAnimations.CURVE_DEFAULT })
 * ```
 */
export class GlassAnimations {
  /** 快速动画时长 100ms（按钮点击等） */
  static readonly DURATION_FAST = 100;
  /** 普通动画时长 150ms */
  static readonly DURATION_NORMAL = 150;
  /** 慢速动画时长 200ms（淡入淡出等） */
  static readonly DURATION_SLOW = 200;
  /** 弹窗动画时长 250ms */
  static readonly DURATION_DIALOG = 250;
  /** 默认缓动曲线 */
  static readonly CURVE_DEFAULT = Curve.EaseOut;
}

/**
 * 毛玻璃 UI 尺寸预设（单位：vp）
 *
 * 使用示例：
 * ```
 * .height(GlassSizes.BUTTON_HEIGHT)
 * ```
 */
export class GlassSizes {
  /** 按钮高度 */
  static readonly BUTTON_HEIGHT = 48;
  /** 输入框高度 */
  static readonly INPUT_HEIGHT = 48;
  /** 列表项高度 */
  static readonly LIST_ITEM_HEIGHT = 56;
  /** 底部导航栏高度 */
  static readonly TAB_BAR_HEIGHT = 64;
  /** 小图标尺寸 */
  static readonly ICON_SM = 18;
  /** 中图标尺寸 */
  static readonly ICON_MD = 20;
  /** 大图标尺寸 */
  static readonly ICON_LG = 22;
  /** 超大图标尺寸 */
  static readonly ICON_XL = 24;
}
