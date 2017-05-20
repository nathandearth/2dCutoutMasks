using UnityEngine;
using System.Collections;

public class CutoutSetup : MonoBehaviour
{
	[SerializeField]
	Camera cutoutCamera;

	void Awake ()
	{
		GenerateRT ();
	}

	public void GenerateRT ()
	{
		if (cutoutCamera.targetTexture != null) {
			RenderTexture temp = cutoutCamera.targetTexture;

			cutoutCamera.targetTexture = null;
			DestroyImmediate (temp);
		}

		RenderTexture rt = new RenderTexture (cutoutCamera.pixelWidth, cutoutCamera.pixelHeight, 16);
		cutoutCamera.targetTexture = rt;
		Shader.SetGlobalTexture ("_CutoutMaskTexture", rt);
	}
}

