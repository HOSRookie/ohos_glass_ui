/**
 * 毛玻璃 UI 色彩常量
 *
 * 统一管理所有颜色值，方便主题定制与维护。
 */
export class GlassColors {
  // ── 主色 ──────────────────────────────────────────
  /** 主色（亮绿） */
  static readonly PRIMARY = '#5DD784';
  /** 主色深一档 */
  static readonly PRIMARY_DARK = '#4CAF50';
  /** 主色最深 */
  static readonly PRIMARY_DARKER = '#43A047';

  // ── 语义色 ────────────────────────────────────────
  /** 危险 / 错误（红） */
  static readonly DANGER = '#FF4D4F';
  /** 警告（黄） */
  static readonly WARNING = '#FAAD14';
  /** 信息（青） */
  static readonly INFO = '#00BCD4';
  /** 成功（绿，同主色） */
  static readonly SUCCESS = '#5DD784';

  // ── 文字色 ────────────────────────────────────────
  /** 一级文字（纯白） */
  static readonly TEXT_PRIMARY = '#FFFFFF';
  /** 二级文字（75% 白） */
  static readonly TEXT_SECONDARY = 'rgba(255, 255, 255, 0.75)';
  /** 三级文字（50% 白） */
  static readonly TEXT_TERTIARY = 'rgba(255, 255, 255, 0.5)';
  /** 四级文字（40% 白，占位符等） */
  static readonly TEXT_QUATERNARY = 'rgba(255, 255, 255, 0.4)';
  /** 禁用文字（30% 白） */
  static readonly TEXT_DISABLED = 'rgba(255, 255, 255, 0.3)';

  // ── 边框色 ────────────────────────────────────────
  /** 默认边框（15% 白） */
  static readonly BORDER_DEFAULT = 'rgba(255, 255, 255, 0.15)';
  /** 浅边框（12% 白） */
  static readonly BORDER_LIGHT = 'rgba(255, 255, 255, 0.12)';
  /** 更浅边框（10% 白） */
  static readonly BORDER_LIGHTER = 'rgba(255, 255, 255, 0.1)';
  /** 聚焦边框（绿色） */
  static readonly BORDER_FOCUS = 'rgba(76, 175, 80, 0.6)';
  /** 幽灵按钮边框（30% 白） */
  static readonly BORDER_GHOST = 'rgba(255, 255, 255, 0.3)';

  // ── 背景色 ────────────────────────────────────────
  /** 透明背景 */
  static readonly BG_TRANSPARENT = Color.Transparent;
  /** 遮罩背景（50% 黑） */
  static readonly BG_OVERLAY = 'rgba(0, 0, 0, 0.5)';
  /** 浅遮罩背景（45% 黑） */
  static readonly BG_OVERLAY_LIGHT = 'rgba(0, 0, 0, 0.45)';
  /** 按下态背景（8% 白） */
  static readonly BG_PRESSED = 'rgba(255, 255, 255, 0.08)';
  /** 悬停背景（5% 白） */
  static readonly BG_HOVER = 'rgba(255, 255, 255, 0.05)';
  /** 禁用背景（30% 灰） */
  static readonly BG_DISABLED = 'rgba(128, 128, 128, 0.3)';
  /** 底部导航栏背景（深蓝半透明） */
  static readonly BG_TAB_BAR = 'rgba(20, 20, 40, 0.6)';

  // ── 按钮背景 ──────────────────────────────────────
  /** 主按钮确认区背景（绿色浅透） */
  static readonly BTN_PRIMARY_BG = 'rgba(93, 215, 132, 0.12)';
  /** 危险按钮确认区背景（红色浅透） */
  static readonly BTN_DANGER_BG = 'rgba(255, 77, 79, 0.12)';
  /** 次要按钮背景（白色浅透） */
  static readonly BTN_SECONDARY_BG = 'rgba(255, 255, 255, 0.06)';

  // ── 阴影色 ────────────────────────────────────────
  /** 默认阴影（20% 黑） */
  static readonly SHADOW_DEFAULT = 'rgba(0, 0, 0, 0.2)';
  /** 中等阴影（25% 黑） */
  static readonly SHADOW_MEDIUM = 'rgba(0, 0, 0, 0.25)';
  /** 较深阴影（30% 黑） */
  static readonly SHADOW_STRONG = 'rgba(0, 0, 0, 0.3)';
  /** 最深阴影（35% 黑） */
  static readonly SHADOW_STRONGER = 'rgba(0, 0, 0, 0.35)';
  /** 主色按钮阴影（绿色） */
  static readonly SHADOW_PRIMARY = 'rgba(76, 175, 80, 0.3)';
  /** 主色按钮按下阴影（绿色加深） */
  static readonly SHADOW_PRIMARY_PRESSED = 'rgba(76, 175, 80, 0.5)';

  // ── 背景渐变 ──────────────────────────────────────
  /**
   * 页面背景渐变色数组（深蓝紫色系）
   * 格式：[颜色, 位置]，位置范围 0~1
   */
  static readonly GRADIENT_COLORS: [ResourceColor, number][] = [
    ['#0a0a2e', 0],
    ['#1a0a3e', 0.3],
    ['#0a1a3e', 0.6],
    ['#0a0a2e', 1]
  ];

  // ── 光斑色 ────────────────────────────────────────
  /** 紫色光斑 */
  static readonly SPOT_PURPLE = '#6C3CE8';
  /** 青色光斑 */
  static readonly SPOT_CYAN = '#00BCD4';
  /** 绿色光斑 */
  static readonly SPOT_GREEN = '#4CAF50';

  // ── 其他 ──────────────────────────────────────────
  /** 输入框错误提示色 */
  static readonly INPUT_ERROR = '#FF6B6B';
  /** 卡片顶部光晕默认色 */
  static readonly GLOW_DEFAULT = 'rgba(255, 255, 255, 0.6)';
  /** 带光晕卡片顶部边框 */
  static readonly BORDER_GLOW_TOP = 'rgba(255, 255, 255, 0.4)';
  /** 面板顶部边框（高亮） */
  static readonly PANEL_BORDER_TOP = 'rgba(255, 255, 255, 0.5)';
  /** 面板侧边框 */
  static readonly PANEL_BORDER_MID = 'rgba(255, 255, 255, 0.15)';
  /** 面板底部边框（弱化） */
  static readonly PANEL_BORDER_BOTTOM = 'rgba(255, 255, 255, 0.06)';
}
