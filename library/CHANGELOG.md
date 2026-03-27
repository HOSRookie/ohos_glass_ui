# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-03-26

### Added
- **GlassCard 光感效果** - 新增 `showGlow` / `glowColor` / `glowOpacity` 参数，开启后在卡片顶部显示柔和光感反射
- **GlassPanel** - 全新高级玻璃面板组件，渐变发光边框（上亮下暗）+ 内部高光 + 毛玻璃穿透

## [1.0.3] - 2026-02-12

### Fixed
- 修复展示图片不能正常显示的问题

## [1.0.2] - 2026-02-06

### Added
- **GlassBackground** - 穿透背景组件（渐变 + 自定义彩色光斑）
- **GlassTabBar** - 悬浮毛玻璃底部导航栏
- **GlassAlert** - 毛玻璃提示弹窗
- **GlassConfirm** - 毛玻璃确认弹窗（支持危险操作样式）
- **GlassBottomSheet** - 毛玻璃底部弹出面板
- **GlassToast** - 毛玻璃 Toast 提示（success/error/warning/none）

### Fixed
- 修复 README.md 中库名与 oh-package.json5 中 name 值不一致的问题（统一使用下划线）
- 统一所有组件为 `Color.Transparent` + `BlurStyle.Thin` 风格

## [1.0.1] - 2026-02-05

### Fixed
- 修复 module.json5 中的模块名称
- 移除示例页面 MainPage.ets

## [1.0.0] - 2026-02-04

### Added

- **GlassCard** - 毛玻璃卡片组件
  - 支持标题、可点击状态
  - 4 级阴影可配置
  - 按压缩放动画反馈

- **GlassListItem** - 毛玻璃列表项组件
  - 左侧图标、右侧箭头
  - 支持危险操作样式（红色）
  - 副标题支持

- **GlassButton** - 毛玻璃按钮组件
  - 4 种按钮类型：PRIMARY / SECONDARY / DANGER / GHOST
  - 加载状态、禁用状态支持

- **GlassInput** - 毛玻璃输入框组件
  - 单行/多行输入
  - 字数统计
  - 聚焦状态绿色边框反馈

- **GlassSelect** - 毛玻璃选择器组件

- **GlassReadonlyField** - 毛玻璃只读字段组件
