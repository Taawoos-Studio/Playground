using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DissolveShaderBehaviour : MonoBehaviour
{
    public Material dissolveMaterial;
    public MeshRenderer meshRenderer;
    [Range(0,1)]
    public float dissolveAmount = 0;

    void Awake()
    {
        this.dissolveAmount = 0;
    }

    void OnWillRenderObject()
    {
        dissolveMaterial.SetFloat("_Amount", dissolveAmount);
        meshRenderer.sharedMaterial = dissolveMaterial;
    }

    public void Dissolve(float duration, Action callback)
    {
        LeanTween.value(0, 1, 1)
        .setOnUpdate((float value)=> { this.dissolveAmount = value; })
        .setOnComplete(()=> { if(callback != null) callback(); });
    }
}
