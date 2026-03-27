import { GlassColors } from '../constants/GlassColors';
import { GlassShadows } from '../constants/GlassStyles';

/**
 * 光斑配置接口
 *
 * 用于定义背景中的彩色模糊光斑（氛围光），可自由叠加多个。
 */
export interface GlassSpot {
  /** 光斑颜色 */
  color: ResourceColor;
  /** 光斑直径（vp） */
  size: number;
  /** 水平位置，支持数值（vp）或百分比字符串 */
  x: number | string;
  /** 垂直位置，支持数值（vp）或百分比字符串 */
  y: number | string;
  /** 不透明度，默认 0.2 */
  opacity?: number;
  /** 高斯模糊半径，默认 80 */
  blur?: number;
}

/** 默认光斑配置：紫、青、绿三色光斑 */
const DEFAULT_SPOTS: GlassSpot[] = [
  { color: GlassColors.SPOT_PURPLE, size: 260, x: -60,   y: 120, opacity: 0.25, blur: 80 },
  { color: GlassColors.SPOT_CYAN,   size: 200, x: '60%', y: 400, opacity: 0.2,  blur: 80 },
  { color: GlassColors.SPOT_GREEN,  size: 180, x: '40%', y: 800, opacity: 0.15, blur: 60 },
];

/**
 * 毛玻璃页面背景组件
 *
 * 提供深色渐变背景 + 彩色光斑氛围，作为页面的底层容器使用。
 * 子内容通过 `content` BuilderParam 插槽注入。
 *
 * 使用示例：
 * ```
 * GlassBackground({
 *   content: () => {
 *     // 页面内容
 *   }
 * })
 * ```
 *
 * 自定义渐变色与光斑：
 * ```
 * GlassBackground({
 *   gradientAngle: 135,
 *   gradientColors: [['#000428', 0], ['#004e92', 1]],
 *   spots: [
 *     { color: '#FF6B6B', size: 200, x: 20, y: 100, opacity: 0.2, blur: 80 }
 *   ],
 *   content: () => { ... }
 * })
 * ```
 */
@ComponentV2
export struct GlassBackground {
  /** 渐变角度（deg），默认 160° */
  @Param gradientAngle: number = 160;
  /** 渐变色数组，格式 [颜色, 位置(0~1)][]，默认深蓝紫色系 */
  @Param gradientColors: [ResourceColor, number][] = GlassColors.GRADIENT_COLORS;
  /** 光斑配置数组，默认紫青绿三色光斑 */
  @Param spots: GlassSpot[] = DEFAULT_SPOTS;
  /** 页面内容插槽 */
  @BuilderParam content: () => void = this.defaultContent;

  @Builder
  private defaultContent(): void {}

  build() {
    Stack() {
      // 渐变背景层
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: this.gradientAngle,
          colors: this.gradientColors,
        })

      // 光斑氛围层
      ForEach(this.spots, (spot: GlassSpot) => {
        Column()
          .width(spot.size)
          .height(spot.size)
          .borderRadius(spot.size / 2)
          .backgroundColor(spot.color)
          .opacity(spot.opacity ?? 0.2)
          .blur(spot.blur ?? 80)
          .position({ x: spot.x, y: spot.y })
      })

      // 页面内容层
      this.content()
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
