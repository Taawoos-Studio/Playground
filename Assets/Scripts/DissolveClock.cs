using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DissolveClock : MonoBehaviour
{
    public GameObject clock;

    private DissolveShaderBehaviour dissolveShaderBehaviour;
    void Start()
    {
        dissolveShaderBehaviour = this.clock.GetComponent<DissolveShaderBehaviour>();       
    }
}
