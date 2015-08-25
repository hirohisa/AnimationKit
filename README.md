# AnimationKit

AnimationKit is a lightweight and easy animation framework.
It provides you that implements a chain of operations with closure and duration like stream of Animation.

## Usage

Create Animation Stream and add animation block to Animation Stream. Using method `start()` is for beginning animation.

```
let animation = Animation("submit")
animation --> (duration, {})
animation.start()
```

### Sequential animation tasks
`-->`  operator to create a group of sequential animations
```
let animation = Animation("submit")
    --> (0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    --> (0.3, { self.submitButton.center = center })
```

### Concurrent animation tasks
`|||`  operator to create a group of concurrent animations
```
let animation = Animation("submit")
    ||| (0.3, { self.submitButton.center = CGPoint(x: center.x, y: 100) })
    ||| (0.3, { self.submitButton.alpha = 0 } )
```
