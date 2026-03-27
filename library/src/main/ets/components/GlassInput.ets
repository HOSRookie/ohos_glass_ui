import { GlassColors } from '../constants/GlassColors';

/**
 * 毛玻璃输入框组件
 *
 * 支持单行与多行两种模式，聚焦时边框高亮，可选字数统计。
 *
 * 使用示例：
 * ```
 * // 单行输入框
 * GlassInput({
 *   label: '用户名',
 *   placeholder: '请输入用户名',
 *   value: this.username,
 *   onChange: (val) => { this.username = val; }
 * })
 *
 * // 多行输入框（带字数限制）
 * GlassInput({
 *   label: '备注',
 *   placeholder: '请输入备注信息',
 *   value: this.remark,
 *   multiLine: true,
 *   multiLineHeight: 120,
 *   maxLength: 200,
 *   onChange: (val) => { this.remark = val; }
 * })
 *
 * // 密码输入框
 * GlassInput({
 *   label: '密码',
 *   placeholder: '请输入密码',
 *   value: this.password,
 *   inputType: InputType.Password,
 *   onChange: (val) => { this.password = val; }
 * })
 * ```
 */
@ComponentV2
export struct GlassInput {
  /** 标签文字，显示在输入框上方 */
  @Param label: string = '';
  /** 占位符文字 */
  @Param placeholder: string = '';
  /** 输入框当前值 */
  @Param value: string = '';
  /** 最大字数限制，0 表示不限制 */
  @Param maxLength: number = 0;
  /** 是否为多行输入，默认 false */
  @Param multiLine: boolean = false;
  /** 多行输入框高度（vp），默认 100 */
  @Param multiLineHeight: number = 100;
  /** 是否只读，只读时禁止编辑 */
  @Param readonly: boolean = false;
  /** 输入框类型，默认普通文本 */
  @Param inputType: InputType = InputType.Normal;
  /** 内容变更回调，参数为最新文本值 */
  @Event onChange: (value: string) => void = () => {};

  @Local private isFocused: boolean = false;

  private getBorderColor(): ResourceColor {
    if (this.isFocused) {
      return GlassColors.BORDER_FOCUS;
    }
    return GlassColors.BORDER_LIGHTER;
  }

  build() {
    Column({ space: 8 }) {
      Row() {
        Text(this.label)
          .fontSize(14)
          .fontColor(GlassColors.TEXT_SECONDARY)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.maxLength > 0) {
          Text(`${this.value.length}/${this.maxLength}`)
            .fontSize(12)
            .fontColor(
              this.value.length >= this.maxLength
                ? GlassColors.INPUT_ERROR
                : GlassColors.TEXT_TERTIARY
            )
        }
      }
      .width('100%')

      if (this.multiLine) {
        TextArea({ text: this.value, placeholder: this.placeholder })
          .width('100%')
          .height(this.multiLineHeight)
          .fontSize(14)
          .fontColor(GlassColors.TEXT_PRIMARY)
          .placeholderColor(GlassColors.TEXT_QUATERNARY)
          .backgroundColor(Color.Transparent)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({
            width: this.isFocused ? 1.5 : 1,
            color: this.getBorderColor()
          })
          .padding(12)
          .maxLength(this.maxLength > 0 ? this.maxLength : undefined)
          .enabled(!this.readonly)
          .onFocus(() => { this.isFocused = true; })
          .onBlur(() => { this.isFocused = false; })
          .onChange((newValue: string) => {
            this.onChange(newValue);
          })
          .animation({ duration: 200, curve: Curve.EaseOut })
      } else {
        TextInput({ text: this.value, placeholder: this.placeholder })
          .width('100%')
          .height(48)
          .fontSize(14)
          .fontColor(GlassColors.TEXT_PRIMARY)
          .placeholderColor(GlassColors.TEXT_QUATERNARY)
          .backgroundColor(Color.Transparent)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({
            width: this.isFocused ? 1.5 : 1,
            color: this.getBorderColor()
          })
          .padding({ left: 12, right: 12 })
          .maxLength(this.maxLength > 0 ? this.maxLength : undefined)
          .type(this.inputType)
          .enabled(!this.readonly)
          .onFocus(() => { this.isFocused = true; })
          .onBlur(() => { this.isFocused = false; })
          .onChange((newValue: string) => {
            this.onChange(newValue);
          })
          .animation({ duration: 200, curve: Curve.EaseOut })
      }
    }
    .width('100%')
  }
}

/**
 * 毛玻璃下拉选择组件
 *
 * 基于系统 Select 封装，提供毛玻璃风格样式。
 *
 * 使用示例：
 * ```
 * GlassSelect({
 *   label: '所在城市',
 *   value: this.city,
 *   options: ['北京', '上海', '广州', '深圳'],
 *   onChange: (val) => { this.city = val; }
 * })
 * ```
 */
@ComponentV2
export struct GlassSelect {
  /** 标签文字，显示在选择框上方 */
  @Param label: string = '';
  /** 当前选中值 */
  @Param value: string = '';
  /** 可选项列表 */
  @Param options: string[] = [];
  /** 选项变更回调，参数为选中的文本值 */
  @Event onChange: (value: string) => void = () => {};

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .fontSize(14)
        .fontColor(GlassColors.TEXT_SECONDARY)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      if (this.options.length === 0) {
        Text('无可选项')
          .fontSize(14)
          .fontColor(GlassColors.TEXT_TERTIARY)
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .backgroundColor(GlassColors.BG_TRANSPARENT)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({ width: 1, color: GlassColors.BORDER_LIGHTER })
      } else {
        Select(this.options.map((item: string) => ({ value: item } as SelectOption)))
          .selected(this.options.indexOf(this.value) >= 0 ? this.options.indexOf(this.value) : 0)
          .value(this.value && this.options.indexOf(this.value) >= 0 ? this.value : this.options[0])
          .font({ size: 14 })
          .fontColor(GlassColors.TEXT_PRIMARY)
          .selectedOptionFont({ size: 14 })
          .optionFont({ size: 14 })
          .width('100%')
          .height(48)
          .backgroundColor(GlassColors.BG_TRANSPARENT)
          .backgroundBlurStyle(BlurStyle.Thin)
          .borderRadius(12)
          .border({ width: 1, color: GlassColors.BORDER_LIGHTER })
          .onSelect((index: number) => {
            if (index >= 0 && index < this.options.length) {
              this.onChange(this.options[index]);
            }
          })
      }
    }
    .width('100%')
  }
}

/**
 * 毛玻璃只读字段组件
 *
 * 以标签 + 值的形式展示不可编辑的信息，常用于详情页。
 *
 * 使用示例：
 * ```
 * GlassReadonlyField({
 *   label: '手机号',
 *   value: this.phone
 * })
 *
 * // 无值时显示占位符
 * GlassReadonlyField({
 *   label: '备注',
 *   value: this.remark,
 *   placeholder: '暂无'
 * })
 * ```
 */
@ComponentV2
export struct GlassReadonlyField {
  /** 字段标签 */
  @Param label: string = '';
  /** 字段值，为空时显示占位符 */
  @Param value: string = '';
  /** 值为空时的占位符，默认"-" */
  @Param placeholder: string = '-';

  build() {
    Row() {
      Text(this.label)
        .fontSize(14)
        .fontColor(GlassColors.TEXT_SECONDARY)

      Blank()

      Text(this.value || this.placeholder)
        .fontSize(14)
        .fontColor(GlassColors.TEXT_TERTIARY)
    }
    .width('100%')
    .height(48)
    .padding({ left: 0, right: 0 })
  }
}
