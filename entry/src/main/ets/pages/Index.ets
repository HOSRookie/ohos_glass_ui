import {
  GlassBackground,
  GlassTabBar,
  GlassTabItem,
  GlassCard,
  GlassButton,
  GlassButtonType,
  GlassInput,
  GlassListItem,
  GlassSelect,
  GlassReadonlyField,
  GlassAlert,
  GlassConfirm,
  GlassBottomSheet,
  GlassToast,
  GlassPanel
} from 'ohos_glass_ui';
import { router } from '@kit.ArkUI';

@Entry
@ComponentV2
struct Index {
  @Local currentTab: number = 0;
  // 弹窗状态
  @Local showAlert: boolean = false;
  @Local showConfirm: boolean = false;
  @Local showSheet: boolean = false;
  @Local showToast: boolean = false;
  @Local toastMsg: string = '';
  @Local toastIcon: 'success' | 'error' | 'warning' | 'none' = 'none';

  private tabs: GlassTabItem[] = [
    { title: '首页', icon: $r('sys.symbol.house'), selectedIcon: $r('sys.symbol.house_fill') },
    { title: '我的', icon: $r('sys.symbol.person'), selectedIcon: $r('sys.symbol.person_fill') },
  ];

  private showToastTip(msg: string, icon: 'success' | 'error' | 'warning' | 'none' = 'success'): void {
    this.toastMsg = msg;
    this.toastIcon = icon;
    this.showToast = true;
  }

  @Builder
  buildHomePage() {
    Scroll() {
      Column({ space: 16 }) {
        Text('ohos_glass_ui')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ top: 56 })

        Text('Glassmorphism UI Components')
          .fontSize(13)
          .fontColor('rgba(255, 255, 255, 0.5)')
          .margin({ bottom: 8 })

        // 光感卡片演示
        GlassCard({ title: '光感卡片', showGlow: true }) {
          Column({ space: 8 }) {
            Text('顶部带有柔和光感反射效果')
              .fontSize(14)
              .fontColor('rgba(255, 255, 255, 0.75)')
            Text('通过 showGlow: true 开启')
              .fontSize(12)
              .fontColor('rgba(255, 255, 255, 0.5)')
          }
          .width('100%')
        }

        // GlassPanel 高级面板演示
        GlassPanel() {
          Column({ space: 12 }) {
            Text('高级玻璃面板')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('渐变发光边框 + 顶部内高光 + 毛玻璃穿透')
              .fontSize(13)
              .fontColor('rgba(255, 255, 255, 0.6)')
          }
          .width('100%')
        }

        // 弹窗演示
        GlassCard({ title: '弹窗 & 提示' }) {
          Column({ space: 8 }) {
            GlassListItem({
              title: 'Alert 提示弹窗',
              showArrow: true,
              onTap: () => { this.showAlert = true; }
            })
            GlassListItem({
              title: 'Confirm 确认弹窗',
              showArrow: true,
              onTap: () => { this.showConfirm = true; }
            })
            GlassListItem({
              title: 'BottomSheet 底部面板',
              showArrow: true,
              onTap: () => { this.showSheet = true; }
            })
            GlassListItem({
              title: 'Toast 提示',
              showArrow: true,
              onTap: () => { this.showToastTip('这是一条 Toast 提示', 'success'); }
            })
            GlassListItem({
              title: '背景穿透效果演示',
              subtitle: '自定义光斑颜色与布局',
              showArrow: true,
              onTap: () => { router.pushUrl({ url: 'pages/DemoPage' }); }
            })
          }
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 80 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  buildMinePage() {
    Scroll() {
      Column({ space: 16 }) {
        // 头像区
        Column({ space: 12 }) {
          Column()
            .width(72)
            .height(72)
            .borderRadius(36)
            .backgroundColor('rgba(93, 215, 132, 0.2)')
            .border({ width: 2, color: '#5DD784' })

          Text('云深')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)

          Text('UID20260206')
            .fontSize(13)
            .fontColor('rgba(255, 255, 255, 0.5)')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 56 })

        // 设置卡片
        GlassCard({ title: '设置' }) {
          Column({ space: 8 }) {
            GlassListItem({
              title: '账号与安全',
              subtitle: '管理您的账号安全设置',
              showArrow: true,
              onTap: () => {}
            })
            GlassListItem({
              title: '隐私设置',
              showArrow: true,
              onTap: () => {}
            })
            GlassListItem({
              title: '关于',
              rightText: 'v1.0.4',
              showArrow: true,
              onTap: () => { this.showToastTip('ohos_glass_ui v1.0.4', 'none'); }
            })
            GlassListItem({
              title: '退出登录',
              danger: true,
              onTap: () => { this.showConfirm = true; }
            })
          }
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 80 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  build() {
    Stack() {
      GlassBackground() {
        Column() {
          // 页面内容
          Stack() {
            if (this.currentTab === 0) {
              this.buildHomePage()
            } else {
              this.buildMinePage()
            }
          }
          .layoutWeight(1)

          // 底部导航栏（毛玻璃穿透）
          GlassTabBar({
            tabs: this.tabs,
            currentIndex: this.currentTab,
            onTabChange: (index: number) => { this.currentTab = index; }
          })
        }
        .width('100%')
        .height('100%')
      }

      // ---- 弹窗层（覆盖在最上层）----
      GlassAlert({
        visible: this.showAlert,
        title: '提示',
        message: '这是一个毛玻璃风格的 Alert 弹窗，背景自动穿透模糊。',
        onConfirm: () => { this.showAlert = false; },
        onClose: () => { this.showAlert = false; }
      })

      GlassConfirm({
        visible: this.showConfirm,
        title: '确认退出',
        message: '退出后需要重新登录，确定要退出吗？',
        danger: true,
        confirmText: '退出',
        onCancel: () => { this.showConfirm = false; },
        onConfirm: () => {
          this.showConfirm = false;
          this.showToastTip('已退出', 'success');
        },
        onClose: () => { this.showConfirm = false; }
      })

      GlassBottomSheet({
        visible: this.showSheet,
        title: '选择操作',
        onClose: () => { this.showSheet = false; }
      }) {
        Column({ space: 8 }) {
          GlassListItem({ title: '拍照', showArrow: true, onTap: () => { this.showSheet = false; this.showToastTip('已选择拍照'); } })
          GlassListItem({ title: '从相册选择', showArrow: true, onTap: () => { this.showSheet = false; this.showToastTip('已选择相册'); } })
          GlassListItem({ title: '取消', danger: true, onTap: () => { this.showSheet = false; } })
        }
      }

      // Toast 层
      GlassToast({
        visible: this.showToast,
        message: this.toastMsg,
        icon: this.toastIcon,
        onClose: () => { this.showToast = false; }
      })
    }
    .width('100%')
    .height('100%')
  }
}
