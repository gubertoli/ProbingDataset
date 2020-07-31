// Decision Tree using netfilter and LKM

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/version.h>	//Needed for LINUX_VERSION_CODE <= KERNEL_VERSION
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>

#define IP_DF 0x4000

static struct nf_hook_ops simpleFilterHook;

// implementation of Filter callback function - Netfilter Hook
#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
static unsigned int simpleFilter(unsigned int hooknum, struct sk_buff *skb, const struct net_device *in, const struct net_device *out, int (*okfn)(struct sk_buff *skb))
#elif LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
static unsigned int simpleFilter(const struct nf_hook_ops *ops, struct sk_buff *skb, const struct net_device *in, const struct net_device *out, int (*okfn)(struct sk_buff *skb))
#elif LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
static unsigned int simpleFilter(const struct nf_hook_ops *ops, struct sk_buff *skb, const struct nf_hook_state *state)
#else
static unsigned int simpleFilter(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
#endif
{

    struct ethhdr *ethh;
    struct iphdr  *iph; 	// ip header struct
    struct tcphdr *tcph;	// tcp header struct
    
    u_int16_t tcp_segment_length; // similar to wireshark ip.len
    //u_int8_t flags;

    ethh = eth_hdr(skb);
    iph = ip_hdr(skb);

    if (!(iph)){
		return NF_ACCEPT;
    }

    if (iph->protocol == IPPROTO_TCP){ // TCP Protocol
	tcph = tcp_hdr(skb);
	
	//flags = ((u_int8_t *)tcph)[13];

	// tcp payload size in bytes
	tcp_segment_length = ntohs(iph->tot_len) - (iph->ihl*4 + tcph->doff*4); 

	//if (tcph->dest == htons(22)){
	//	printk(KERN_INFO "tcp.th_flags: %d", flags); 
	//}

	/**** Start of Decision Tree ****/
	
	if (iph->tot_len < htons(65)) {
              if (tcph->fin == 0) {
                  if ((tcph->doff*4) < htons(38)) {
                      if ((iph->frag_off & IP_DF) == 0) {
                          if (tcph->syn == 0) {
                              if (iph->tot_len < htons(41)) {
                                  return NF_DROP;
                              } else {
                                  return NF_ACCEPT;
                              }
                          } else {
                              if (tcph->window < htons(521)) {
                                  return NF_DROP;
                              } else {
                                  return NF_ACCEPT;
                              }
                          }
                      } else {
                          if (tcph->window < htons(1)) {
                              if (iph->id < htons(60)) {
                                  return NF_DROP;
                              } else {
                                  return NF_ACCEPT;
                              }
                          } else {
                              if ((unsigned int)tcp_segment_length < 19) {
                                  return NF_ACCEPT;
                              } else {
                                  return NF_ACCEPT;
                              }
                          }
                      }
                  } else {
                      if (tcph->window < htons(15749)) {
                          return NF_ACCEPT;
                      } else {
                          if (tcph->window < htons(64520)) {
                              if (iph->id < htons(11)) {
                                  return NF_ACCEPT;
                              } else {
                                  return NF_DROP;
                              }
                          } else {
                              if (iph->tot_len < htons(62)) {
                                  return NF_ACCEPT;
                              } else {
                                  return NF_ACCEPT;
                              }
                          }
                      }
                  }
              } else {
                  if (tcph->window < htons(512)) {
                      return NF_ACCEPT;
                  } else {
                      if (iph->id < htons(2)) {
                          return NF_ACCEPT;
                      } else {
                          if (tcph->window < htons(16498)) {
                              if (iph->tos < htons(4)) {
                                  return NF_DROP;
                              } else {
                                  return NF_ACCEPT;
                              }
                          } else {
                              return NF_ACCEPT;
                          }
                      }
                  }
              }
          } else {
              if (iph->tot_len < htons(66)) {
                  return NF_ACCEPT;
              } else {
                  return NF_ACCEPT;
              }
          }
        }
	/**** End of Decision Tree ****/

    return NF_ACCEPT;
}

// Netfilter hook

static struct nf_hook_ops simpleFilterHook = {
    .hook	= simpleFilter,
    .hooknum	= NF_INET_PRE_ROUTING,
    .pf		= PF_INET,
    .priority	= NF_IP_PRI_FIRST,
#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
    .owner	= THIS_MODULE
#endif
};

int setUpFilter(void){
    printk(KERN_INFO "Registering Simple Filter.\n");

    //register the hook
    #if LINUX_VERSION_CODE <= KERNEL_VERSION(4,12,14)
    	nf_register_hook(&simpleFilterHook);
    #else
	nf_register_net_hook(&init_net, &simpleFilterHook);
    #endif
    return 0;
}

void removeFilter(void){
    printk(KERN_INFO "Simple Filter is being removed.\n");
    
    //unregister the hook
    #if LINUX_VERSION_CODE <= KERNEL_VERSION(4,12,14)
	nf_register_hook(&simpleFilterHook);
    #else
        nf_unregister_net_hook(&init_net, &simpleFilterHook);
    #endif
}

module_init(setUpFilter);
module_exit(removeFilter);

MODULE_LICENSE("GPL");
