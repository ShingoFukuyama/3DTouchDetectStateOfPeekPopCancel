
# 3D Touch sample - Detecting Peek/Pop/Peak-Cancel

## Peek
Check gesture state of `previewingGestureRecognizerForFailureRelationship` property of `UIViewControllerPreviewing`.
When peeking, the state is `.Began` or `.Changed`.

## Pop
Before popped, `previewingContext(_:commitViewController:)` method called.

## Peek-Cancel
Observe gesture state of `previewingGestureRecognizerForFailureRelationship` by KVO (Key-Value Observing)


![demo](https://raw.githubusercontent.com/ShingoFukuyama/3DTouchDetectStateOfPeekPopCancel/master/demo.gif)
