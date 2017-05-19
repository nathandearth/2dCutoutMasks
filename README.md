## Features Trailer
<a href="http://www.youtube.com/watch?feature=player_embedded&v=VUusYgx3ecM" target="_blank"><img src="http://img.youtube.com/vi/VUusYgx3ecM/0.jpg" width="320" height="180" border="10" /></a>

## Introduction
*2d Cutout Masks* is a shader for unity, that uses masks to cut out sprites. 

### Features
 - Easy to use
 - Any shape
 - Alpha
 - Sprite color
 - Unity Animations
 - Rotation
 - Transparency
 - Pixel snap
 - Unlimited number of masks
 - Per-sprite coloring
 
## Getting Started

### Camera Setup
Start by duplicating your main camera. Then, in the inspector, set it's "Culling Mask" feild to only include the layer that all your masks are on. Note, make sure your second camera's "clear flags" settings are clearing to full transparency, and if you change your main camera's orthographic size or field of vision, you will want to copy those changes to your second camera. Now add the "Cutout Setup" commponent to your second camera, and drag the second camera into the "Coutout Camera" field. Each time the window is resized, you will need to call the "GenerateRT" method inside the "CutoutSetup" script. It's worth noting, in the top right corner of unity's editor you can turn off the "masks" layer's visibility.

#### Optional
If you know how Render Textures work, you can make one with your preferred method, then assign it to the shader though Unity's SetGlobalTexture method. (See code for example)

### Mask images
*2d Cutout Masks* uses images' alpha channel to cut out pixels. Full alpha range is supported, and you can make them in any shape or size you want. Make sure your image's "Alpha Source" settings are properly set, in the inspector.

### Materials
In Unity, create a new material. In the "Shader" dropdown menu, of the inspector, chose CutoutMasks/Cutout. Adjust the options according to your needs, then drag the material to the sprites you want cutout.

#### Material Options
- Invert, switches between cutting out everything inside the mask, or outside the mask.
- Pixel snap, enables Unity's pixel snapping.
- Direct3D & Anti-Aliasing, if you are using DirectX like rendering and anti-aliasing, you will need to check this box. [More info here](https://docs.unity3d.com/Manual/SL-PlatformDifferences.html).
 
## License
This software is released under the [MIT license](http://opensource.org/licenses/MIT).

## Follow Me Here
[Twitter](https://twitter.com/NathanLDearth)
