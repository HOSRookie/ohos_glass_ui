import { GlassColors } from '../constants/GlassColors';
import { GlassShadows } from '../constants/GlassStyles';

/**
 * 毛玻璃警告弹窗组件
 *
 * 单按钮确认弹窗，点击遮罩或确认按钮均可关闭。
 *
 * 使用示例：
 * ```
 * GlassAlert({
 *   visible: this.showAlert,
 *   title: '提示',
 *   message: '操作已完成',
 *   confirmText: '好的',
 *   onConfirm: () => { this.showAlert = false; },
 *   onClose: () => { this.showAlert = false; }
 * })
 * ```
 */
@ComponentV2
export struct GlassAlert {
  /** 是否显示弹窗 */
  @Param visible: boolean = false;
  /** 弹窗标题，默认"提示" */
  @Param title: string = '提示';
  /** 弹窗正文内容 */
  @Param message: string = '';
  /** 确认按钮文字，默认"确定" */
  @Param confirmText: string = '确定';
  /** 点击确认按钮回调 */
  @Event onConfirm: () => void = () => {};
  /** 点击遮罩关闭回调 */
  @Event onClose: () => void = () => {};

  build() {
    if (this.visible) {
      Stack() {
        // 半透明遮罩，点击关闭
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .onClick(() => { this.onClose(); })

        Column({ space: 20 }) {
          Text(this.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Text(this.message)
            .fontSize(14)
            .fontColor('rgba(255, 255, 255, 0.75)')
            .lineHeight(22)
            .textAlign(TextAlign.Center)

          Text(this.confirmText)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#5DD784')
            .width('100%')
            .height(44)
            .textAlign(TextAlign.Center)
            .borderRadius(12)
            .backgroundColor('rgba(93, 215, 132, 0.12)')
            .onClick(() => { this.onConfirm(); })
        }
        .width('80%')
        .padding(24)
        .borderRadius(20)
        .backgroundColor(Color.Transparent)
        .backgroundBlurStyle(BlurStyle.Thin)
        .border({ width: 1, color: 'rgba(255, 255, 255, 0.15)' })
        .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.25)', offsetY: 6 })
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
      .transition(TransitionEffect.opacity(0.01).animation({ duration: 200 }))
    }
  }
}

/**
 * 毛玻璃确认弹窗组件
 *
 * 双按钮确认弹窗，支持普通确认与危险操作两种样式。
 *
 * 使用示例：
 * ```
 * // 普通确认
 * GlassConfirm({
 *   visible: this.showConfirm,
 *   title: '确认提交',
 *   message: '提交后无法修改，是否继续？',
 *   onConfirm: () => { this.submit(); },
 *   onCancel: () => { this.showConfirm = false; },
 *   onClose: () => { this.showConfirm = false; }
 * })
 *
 * // 危险操作（确认按钮变红）
 * GlassConfirm({
 *   visible: this.showDelete,
 *   title: '删除确认',
 *   message: '此操作不可恢复，确定要删除吗？',
 *   danger: true,
 *   confirmText: '删除',
 *   onConfirm: () => { this.delete(); },
 *   onCancel: () => { this.showDelete = false; },
 *   onClose: () => { this.showDelete = false; }
 * })
 * ```
 */
@ComponentV2
export struct GlassConfirm {
  /** 是否显示弹窗 */
  @Param visible: boolean = false;
  /** 弹窗标题，默认"确认" */
  @Param title: string = '确认';
  /** 弹窗正文内容 */
  @Param message: string = '';
  /** 取消按钮文字，默认"取消" */
  @Param cancelText: string = '取消';
  /** 确认按钮文字，默认"确定" */
  @Param confirmText: string = '确定';
  /** 是否为危险操作，开启后确认按钮变红 */
  @Param danger: boolean = false;
  /** 点击取消按钮回调 */
  @Event onCancel: () => void = () => {};
  /** 点击确认按钮回调 */
  @Event onConfirm: () => void = () => {};
  /** 点击遮罩关闭回调 */
  @Event onClose: () => void = () => {};

  build() {
    if (this.visible) {
      Stack() {
        // 半透明遮罩，点击关闭
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .onClick(() => { this.onClose(); })

        Column({ space: 20 }) {
          Text(this.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Text(this.message)
            .fontSize(14)
            .fontColor('rgba(255, 255, 255, 0.75)')
            .lineHeight(22)
            .textAlign(TextAlign.Center)

          Row({ space: 12 }) {
            Text(this.cancelText)
              .fontSize(15)
              .fontColor('rgba(255, 255, 255, 0.7)')
              .layoutWeight(1)
              .height(44)
              .textAlign(TextAlign.Center)
              .borderRadius(12)
              .backgroundColor('rgba(255, 255, 255, 0.06)')
              .border({ width: 0.5, color: 'rgba(255, 255, 255, 0.12)' })
              .onClick(() => { this.onCancel(); })

            Text(this.confirmText)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.danger ? '#FF4D4F' : '#5DD784')
              .layoutWeight(1)
              .height(44)
              .textAlign(TextAlign.Center)
              .borderRadius(12)
              .backgroundColor(this.danger ? 'rgba(255, 77, 79, 0.12)' : 'rgba(93, 215, 132, 0.12)')
              .onClick(() => { this.onConfirm(); })
          }
          .width('100%')
        }
        .width('80%')
        .padding(24)
        .borderRadius(20)
        .backgroundColor(Color.Transparent)
        .backgroundBlurStyle(BlurStyle.Thin)
        .border({ width: 1, color: 'rgba(255, 255, 255, 0.15)' })
        .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.25)', offsetY: 6 })
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
      .transition(TransitionEffect.opacity(0.01).animation({ duration: 200 }))
    }
  }
}

/**
 * 毛玻璃底部弹出面板组件
 *
 * 从屏幕底部滑入的内容面板，支持标题和自定义内容插槽。
 * 点击遮罩区域关闭面板。
 *
 * 使用示例：
 * ```
 * GlassBottomSheet({
 *   visible: this.showSheet,
 *   title: '选择操作',
 *   onClose: () => { this.showSheet = false; },
 *   content: () => {
 *     GlassListItem({ title: '选项一', onTap: () => {} })
 *     GlassListItem({ title: '选项二', onTap: () => {} })
 *   }
 * })
 * ```
 */
@ComponentV2
export struct GlassBottomSheet {
  /** 是否显示面板 */
  @Param visible: boolean = false;
  /** 面板标题，为空时不渲染标题行 */
  @Param title: string = '';
  /** 点击遮罩关闭回调 */
  @Event onClose: () => void = () => {};
  /** 内容插槽 */
  @BuilderParam content: () => void = this.defaultContent;

  @Builder
  private defaultContent(): void {}

  build() {
    if (this.visible) {
      Stack({ alignContent: Alignment.Bottom }) {
        // 半透明遮罩，点击关闭
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0, 0, 0, 0.45)')
          .onClick(() => { this.onClose(); })

        Column({ space: 16 }) {
          // 顶部拖拽指示条
          Column()
            .width(36)
            .height(4)
            .borderRadius(2)
            .backgroundColor('rgba(255, 255, 255, 0.25)')

          if (this.title) {
            Text(this.title)
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .width('100%')
          }

          this.content()
        }
        .width('100%')
        .padding({ top: 12, left: 20, right: 20, bottom: 40 })
        .borderRadius({ topLeft: 24, topRight: 24 })
        .backgroundColor(Color.Transparent)
        .backgroundBlurStyle(BlurStyle.Thin)
        .border({ width: { top: 1 }, color: 'rgba(255, 255, 255, 0.15)' })
        .transition(TransitionEffect.move(TransitionEdge.BOTTOM).animation({ duration: 250, curve: Curve.EaseOut }))
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
    }
  }
}
