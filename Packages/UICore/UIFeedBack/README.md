# UIFeedBack

震动反馈

## ImpactGenerator
预示着按压发生了。比如系统触感强度设置就是为了在你按 Home 键的时候给你一反馈，实际上 iPhone 7 的 Home 键并可以按动。


## NotificationGenerator
预示着成功、失败和警告。比如 Apple_Pay 支付成功和失败的反馈，这里比较了下三种情况的反馈，应该是在力度上面有所差别。和 Impact 的差别在于，这里的触觉反馈类似左右摇动两下。


## SelectionGenerator
预示着选择的变化。比如饿了么的刷新触觉反馈，这里普及一下，这种刷新反馈是因为饿了么使用的系统的 UIRefreshControl 方法去做的下拉刷新，而系统为这种方法下拉的 offsetY 做了触觉反馈的适配。
