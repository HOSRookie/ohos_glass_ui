# ohos_glass_ui

<p align="center">
  <img src="https://img.shields.io/badge/HarmonyOS-NEXT-blue" alt="HarmonyOS NEXT">
  <img src="https://img.shields.io/badge/API-12+-green" alt="API 12+">
  <img src="https://img.shields.io/badge/ArkTS-V2-orange" alt="ArkTS V2">
  <img src="https://img.shields.io/badge/License-Apache%202.0-lightgrey" alt="License">
</p>

**HarmonyOS NEXT 毛玻璃风格 UI 组件库**

Glassmorphism 风格组件库，提供开箱即用的毛玻璃背景、卡片、面板、按钮、输入框、导航栏、弹窗、Toast 等 14 个组件，统一穿透模糊视觉风格。

## 效果预览

| 我的页面 | 穿透效果 | Alert 弹窗 |
|:---:|:---:|:---:|
| ![我的](https://raw.githubusercontent.com/HOSRookie/ohos_glass_ui/main/library/screenshots/mine.png) | ![穿透](https://raw.githubusercontent.com/HOSRookie/ohos_glass_ui/main/library/screenshots/demo.png) | ![Alert](https://raw.githubusercontent.com/HOSRookie/ohos_glass_ui/main/library/screenshots/alert.png) |

| Confirm 弹窗 | BottomSheet |
|:---:|:---:|
| ![Confirm](https://raw.githubusercontent.com/HOSRookie/ohos_glass_ui/main/library/screenshots/confirm.png) | ![BottomSheet](https://raw.githubusercontent.com/HOSRookie/ohos_glass_ui/main/library/screenshots/bottomsheet.png) |

## 特性

- **毛玻璃穿透** - 基于 `backgroundBlurStyle` 的真实模糊效果，背景色彩自然穿透
- **14 个组件** - 覆盖背景、卡片、面板、按钮、输入、导航、弹窗、Toast 等常用场景
- **光感效果** - GlassCard 支持光感高光，GlassPanel 提供高级玻璃面板质感
- **深色主题** - 专为深色背景设计，统一的视觉语言
- **零依赖** - 纯 ArkTS 实现，无外部依赖
- **ArkUI V2** - 基于 @ComponentV2 开发，状态管理更高效
- **开箱即用** - `GlassBackground` 一行代码搞定穿透背景

## 下载安装

```bash
ohpm install ohos_glass_ui
```

或在 `oh-package.json5` 中添加：

```json5
{
  "dependencies": {
    "ohos_glass_ui": "^1.0.4"
  }
}
```

## 快速开始

使用 `GlassBackground` 包裹内容，所有 Glass 组件自动获得穿透效果：

```typescript
import { GlassBackground, GlassCard, GlassButton, GlassButtonType } from 'ohos_glass_ui';

@Entry
@ComponentV2
struct MyPage {
  build() {
    Stack() {
      GlassBackground() {
        Column({ space: 16 }) {
          GlassCard({ title: '标题' }) {
            Column({ space: 12 }) {
              Text('毛玻璃卡片内容')
                .fontColor(Color.White)

              GlassButton({
                text: '确定',
                type: GlassButtonType.PRIMARY,
                onTap: () => {}
              })
            }
          }
        }
        .width('100%')
        .padding(16)
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

## 组件列表

### GlassBackground - 穿透背景

提供渐变底色 + 彩色模糊光斑，让所有 Glass 组件有内容可模糊。

```typescript
// 默认光斑（紫/青/绿）
GlassBackground() {
  // 内容
}

// 自定义光斑
GlassBackground({
  spots: [
    { color: '#FF6B6B', size: 240, x: -40, y: 100, opacity: 0.25 },
    { color: '#4ECDC4', size: 200, x: '65%', y: 500, opacity: 0.2 },
  ],
  gradientColors: [['#0a0a2e', 0], ['#1a0a3e', 0.5], ['#0a0a2e', 1]]
}) {
  // 内容
}
```

### GlassCard - 毛玻璃卡片

```typescript
GlassCard({
  title: '标题',
  titleSize: 16,
  clickable: true,
  cardPadding: 16,
  cardRadius: 16,
  blurStyle: BlurStyle.Thin,
  shadowLevel: 1,          // 1-4
  showGlow: false,          // 光感效果
  glowColor: 'rgba(255, 255, 255, 0.6)',
  glowOpacity: 0.25,        // 0~1
  onTap: () => {}
}) {
  // 内容 Builder
}
```

### GlassPanel - 高级玻璃面板

渐变发光边框 + 内部高光 + 毛玻璃穿透，模拟真实玻璃面板质感。

```typescript
GlassPanel({
  panelPadding: 16,
  panelRadius: 20,
  panelBorderWidth: 1,           // 渐变边框宽度
  glowOpacity: 0.2,         // 顶部内高光强度
  shadowLevel: 3,           // 1-4
  blurStyle: BlurStyle.Thin
}) {
  // 内容 Builder
}
```

### GlassListItem - 列表项

```typescript
GlassListItem({
  title: '账号与安全',
  subtitle: '管理您的账号安全设置',
  icon: $r('sys.symbol.shield'),
  rightText: 'v1.0',
  showArrow: true,
  danger: false,
  onTap: () => {}
})
```

### GlassButton - 按钮

支持 4 种类型：PRIMARY（绿色渐变）、SECONDARY（毛玻璃）、DANGER（红色）、GHOST（透明边框）。

```typescript
GlassButton({
  text: '确认',
  type: GlassButtonType.PRIMARY,
  disabled: false,
  loading: false,
  buttonHeight: 48,
  buttonRadius: 16,
  fullWidth: true,
  onTap: () => {}
})
```

### GlassInput - 输入框

```typescript
GlassInput({
  label: '昵称',
  placeholder: '请输入昵称',
  value: this.name,
  maxLength: 20,
  multiLine: false,
  readonly: false,
  inputType: InputType.Normal,
  onChange: (value: string) => {}
})
```

### GlassSelect - 选择器

```typescript
GlassSelect({
  label: '性别',
  value: this.gender,
  options: ['保密', '男', '女'],
  onChange: (value: string) => {}
})
```

### GlassReadonlyField - 只读字段

```typescript
GlassReadonlyField({
  label: '用户ID',
  value: 'UID123456',
  placeholder: '-'
})
```

### GlassTabBar - 悬浮导航栏

悬浮胶囊造型底部导航栏，毛玻璃穿透效果。

```typescript
GlassTabBar({
  tabs: [
    { title: '首页', icon: $r('sys.symbol.house'), selectedIcon: $r('sys.symbol.house_fill') },
    { title: '我的', icon: $r('sys.symbol.person'), selectedIcon: $r('sys.symbol.person_fill') }
  ],
  currentIndex: this.currentTab,
  activeColor: '#5DD784',
  barHeight: 64,
  barRadius: 32,
  bottomOffset: 24,
  horizontalMargin: 24,
  onTabChange: (index: number) => { this.currentTab = index; }
})
```

### GlassAlert - 提示弹窗

```typescript
GlassAlert({
  visible: this.showAlert,
  title: '提示',
  message: '操作成功',
  confirmText: '确定',
  onConfirm: () => { this.showAlert = false; },
  onClose: () => { this.showAlert = false; }
})
```

### GlassConfirm - 确认弹窗

```typescript
GlassConfirm({
  visible: this.showConfirm,
  title: '确认退出',
  message: '退出后需要重新登录',
  cancelText: '取消',
  confirmText: '退出',
  danger: true,             // 红色确认按钮
  onCancel: () => { this.showConfirm = false; },
  onConfirm: () => { /* 执行退出 */ },
  onClose: () => { this.showConfirm = false; }
})
```

### GlassBottomSheet - 底部面板

```typescript
GlassBottomSheet({
  visible: this.showSheet,
  title: '选择操作',
  onClose: () => { this.showSheet = false; }
}) {
  Column({ space: 8 }) {
    GlassListItem({ title: '拍照', showArrow: true, onTap: () => {} })
    GlassListItem({ title: '从相册选择', showArrow: true, onTap: () => {} })
  }
}
```

### GlassToast - Toast 提示

```typescript
GlassToast({
  visible: this.showToast,
  message: '操作成功',
  icon: 'success',          // 'success' | 'error' | 'warning' | 'none'
  duration: 2000,           // 自动消失时间（ms）
  onClose: () => { this.showToast = false; }
})
```

## 设计规范

### 颜色变量

| 用途 | 颜色值 |
|------|--------|
| 主按钮渐变 | `#5DD784` → `#4CAF50` → `#43A047` |
| 选中/聚焦 | `#5DD784` |
| 危险色 | `#FF4D4F` |
| 警告色 | `#FAAD14` |
| 文字主色 | `#FFFFFF` |
| 文字次色 | `rgba(255, 255, 255, 0.5)` |
| 边框色 | `rgba(255, 255, 255, 0.15)` |

### 毛玻璃效果说明

所有组件使用 `backgroundBlurStyle(BlurStyle.Thin)` + `backgroundColor(Color.Transparent)` 实现穿透效果。**必须配合 `GlassBackground` 或自定义彩色背景使用**，纯色背景下模糊效果不可见。

## 约束与限制

- **开发环境**：DevEco Studio 5.0.0 或以上
- **SDK 版本**：HarmonyOS NEXT API 12 (6.0.2) 或以上
- **语言**：ArkTS（基于 @ComponentV2）
- **主题**：当前版本仅支持深色主题
- **设备类型**：phone、tablet、2in1
- **背景要求**：需配合 `GlassBackground` 或彩色/渐变背景使用

## 许可证

[Apache License 2.0](./LICENSE)

## 作者

**云深**
