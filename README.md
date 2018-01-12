# PictureZoom
双击放大图片点击位置+捏合缩放

<p>使用</p>

<pre><code>

/** 代码 */
let imgZoom = ImageZoomView.init(frame: CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 500))
imgZoom.imgs = [image1, image2]

view.addSubview(imgZoom)

/** xib */
imgZoomView.imgs = [image1, image2]

</code></pre>
