import {
  GlassBackground,
  GlassCard,
  GlassButton,
  GlassButtonType,
  GlassInput,
  GlassListItem,
  GlassSelect,
  GlassReadonlyField,
  GlassSpot
} from 'ohos_glass_ui';
import { router } from '@kit.ArkUI';

@Entry
@ComponentV2
struct DemoPage {
  @Local username: string = '';
  @Local password: string = '';
  @Local gender: string = '保密';

  // 自定义更丰富的光斑，展示穿透效果
  private spots: GlassSpot[] = [
    { color: '#9C27B0', size: 300, x: -80, y: 60, opacity: 0.3, blur: 90 },
    { color: '#E91E63', size: 220, x: '70%', y: 200, opacity: 0.25, blur: 80 },
    { color: '#00BCD4', size: 250, x: '20%', y: 500, opacity: 0.25, blur: 85 },
    { color: '#4CAF50', size: 200, x: '60%', y: 750, opacity: 0.2, blur: 70 },
    { color: '#FF9800', size: 180, x: -30, y: 950, opacity: 0.2, blur: 75 },
  ];

  build() {
    Stack() {
      GlassBackground({ spots: this.spots }) {
        Scroll() {
          Column({ space: 16 }) {
            // 顶部返回栏
            Row() {
              Text('< 返回')
                .fontSize(16)
                .fontColor('rgba(255, 255, 255, 0.8)')
                .onClick(() => {
                  router.back();
                })
              Blank()
              Text('穿透效果演示')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
              Blank()
              Text('      ')
                .fontSize(16)
            }
            .width('100%')
            .margin({ top: 52 })

            // 登录卡片
            GlassCard({ title: '登录' }) {
              Column({ space: 12 }) {
                GlassInput({
                  label: '用户名',
                  placeholder: '请输入用户名',
                  value: this.username,
                  maxLength: 20,
                  onChange: (value: string) => {
                    this.username = value;
                  }
                })

                GlassInput({
                  label: '密码',
                  placeholder: '请输入密码',
                  value: this.password,
                  inputType: InputType.Password,
                  onChange: (value: string) => {
                    this.password = value;
                  }
                })

                GlassSelect({
                  label: '性别',
                  value: this.gender,
                  options: ['保密', '男', '女'],
                  onChange: (value: string) => {
                    this.gender = value;
                  }
                })

                GlassReadonlyField({
                  label: '用户ID',
                  value: 'UID20260206',
                })

                GlassButton({
                  text: '登录',
                  type: GlassButtonType.PRIMARY,
                  onTap: () => {
                    console.info(`用户名: ${this.username}, 性别: ${this.gender}`);
                  }
                })
              }
            }

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
                  title: '退出登录',
                  danger: true,
                  onTap: () => {}
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
    }
    .width('100%')
    .height('100%')
  }
}
