# AnimationKit

AnimationKit is a lightweight and easy animation framework.
It provides you that implements a chain of operations with closure and duration like stream of Animation.

## Usage

Create Stream for Animation and add animation blocks to it. Using method `start()` is for beginning stream for Animation.

```
let animation = Animation("submit")
    animation --> (duration, {})
    animation.start()
```

### Sequential animation tasks
`append`, `-->` operator to create a group of sequential animations
```
let animation = Animation("submit")
    animation.append(0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    animation --> (0.3, { self.submitButton.center = center })
```

### Concurrent animation tasks
`union`, `|||` operator to create a group of concurrent animations
```
let animation = Animation("submit")
    animation.union(0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    animation ||| (0.3, { self.submitButton.alpha = 0 } )
```
